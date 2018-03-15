%[percent,yotal,PM]=independ_gid(S,T,m,si,ti,K)
%S:ѵ�������������͡�S=S1US2US3U...USm
%T:���Լ����������͡�T=T1UT2UT3U...UTm
%m:ģʽ��
%k:KNN�㷨�Ĵ��ڲ���K
%sindex:ѵ�����������Ԫ�ص���Ŀ
%tindex:���Լ��������Ԫ�ص���Ŀ
%�������ܣ��û��ڻ�ɫ�����ȵ�������㷨(KNN)�Բ��Լ�Y����Ԥ�⡣�ó�������ȷ��ʶ���ʺ��ܵ�ʶ���ʡ�
function [percent,total,PM]=independ_gid(Learn,Test,type,Learn_Count,Test_Count,n)
    Good=zeros(1,type);
    PM = zeros(type,type);%�б����PM(i,j)��ʾ��i����Ϊj��
    S=[];
    for i=1:type
        M=CellToMatrix(Learn{i});
        S=[S;M];
    end
    si = AGO(Learn_Count);
    for i=1:type
        for j=1:Test_Count(i)
            x=Test{i}{j};%���б���������������Ӧ�����ڵ�i��
            %r=GreyIncidenceDegree(S,x');
            r = CosinDistance(S,x');
            [C,IX]=sort(r,'descend');%�Թ����Ƚ������У�ǰk��Ϊ���������
            vote = zeros(1,type);
            for k = 1:n
                %K���ڷ�
                knn = zeros(1,type);%��¼ÿһ��Ľ�����
                for t=1:k
                    m=1;
                    while( IX(t) > si(m) ) 
                        m=m+1;
                    end
                    knn(m) = knn(m)+1;%��IX(t)��Ϊm��
                end
                [val,kind] = max(knn);%������������ģʽ��kind�࣬���ѱ����ڵ�i�������x��Ϊ��kind�ࡣ
                vote(kind) = vote(kind) + 1; 
            end
            [val, kind] = max(vote);
            PM(i,kind) = PM(i,kind) + 1;
        end
    end
    
    for i = 1:type
        Good(i) = PM(i,i);
    end
    percent=Good./(Test_Count);
    total=sum(Good)/sum(Test_Count);
            
            
        
