%�û�ɫ��������Ϊ���뺯����Vector_Group��jack-knife����Ԥ��
%Vector_Group:cell(1,n)n��ģʽ�����������У�Vector_Group{i}��cell(1,ni)�ͣ���ʾi��ģʽ����ni������
%Group_Count:ÿ��ģʽ�������ĸ���
%type:ģʽ��
%k:������
function [percent,total,PM]=jkgid(Vector_Group,Group_Count,type,num)
    Good=zeros(1,type);
    PM = zeros(type,type);%�б����PM(i,j)��ʾ��i����Ϊj��
    S=[];
    for i=1:type
        M=CellToMatrix(Vector_Group{i});
        S=[S;M];
    end
    
    n = 1;
    for i=1:type
        for j=1:Group_Count(i)
            x=Vector_Group{i}{j};%���б���������������Ӧ�����ڵ�i��
            R=S;
            R(n,:)=[];%��x�ų�
            r=GreyIncidenceDegree(R,x');
            gc=Group_Count;
            gc(i)=gc(i)-1;%��Ӧ�ص�i�������������1
            si=AGO(gc);
            [C,IX]=sort(r,'descend');%�Թ����Ƚ������У�ǰk��Ϊ���������
            
            vote = zeros(1,type);
            for k=1:num
                %K���ڷ�
                knn = zeros(1,type);%��¼ÿһ��Ľ�����
                for t=1:k
                    m=1;
                    while( IX(t) > si(m)) 
                        m=m+1;
                    end
                    knn(m) = knn(m)+1;%��IX(t)��Ϊm��
                end
                [val,kind] = max(knn);%������������ģʽ��kind�࣬���ѱ����ڵ�i�������x��Ϊ��kind�ࡣ
                vote(kind) = vote(kind) + 1; 
            end
            [val, kind] = max(vote);
            PM(i,kind) = PM(i,kind) + 1;
            n = n + 1;
        end
    end
    
    for i = 1:type
        Good(i) = PM(i,i);
    end
    percent=Good./Group_Count;
    total=sum(Good)/sum(Group_Count);
            
            
        
