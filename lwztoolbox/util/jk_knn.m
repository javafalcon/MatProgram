%k�����㷨��jack knife����
%Vector_Group����������������m��ģʽ
%Group_Count��ÿ��ģʽ��������
%knum:������
function [percent,total,PM] = jk_knn(Vector_Group,Group_Count,knum,dist)
type = length(Vector_Group);%typeģʽ��
PM = zeros(type,type);%�б����PM(i,j)��ʾ��i����Ϊj��

%��cell����Vector_Groupת��Ϊ����ÿ��������Ϊ�����������
S=[];
for i=1:type
    M=CellToMatrix(Vector_Group{i});
    S=[S;M];
end

%jackknife����
n = 1;
m = sum(Group_Count) - 1;
for i = 1:type
    for j = 1:Group_Count(i)
        x = Vector_Group{i}{j}';
        
        R = S;
        R(n,:)=[];%��x�ų�
        gc = Group_Count;
        gc(i) = gc(i) - 1;%��Ӧ�ص�i�������������1
        
        %����x��R��ÿ�������ľ���
        d = zeros(1,m);
        switch dist
            case {'cosin'}
                for ii = 1:m
                    y = R(ii,:);%R�ĵ�i������
                    d(ii) = CosAngleDistance(x,y);%���Ҿ���
                end
            case {'minkowski'}
                for ii = 1:m
                    y = R(ii,:)
                    d(ii) = MinkowskiDistance(x,y,1);%���Ͼ���
                end
            case {'gid'}
                d = GreyIncidenceDegree(R,x);
        end
        
        [C,IX]=sort(d,'descend');%�Ծ��뽵�����С�
        
        %k�����㷨��IX�е�ǰk��ֵ����
        si = AGO(gc);
        knnv = zeros(1,type);%��¼ÿһ��Ľ�����
        for t = 1:knum
            f=1;
            while( IX(t) > si(f) ) 
                f = f + 1;
            end
            knnv(f) = knnv(f) + 1;%��IX(t)��Ϊf��
        end
        [val,kind] = max(knnv);%������������ģʽ��kind�࣬����x��Ϊ��kind�ࡣ
        
        PM(i,kind) = PM(i,kind) + 1;%�ѵ�i��������ж�Ϊ��kind��
        
        n=n+1;
    end
end

Good=zeros(1,type);%���еĸ���
for i = 1:type
    Good(i) = PM(i,i);
end
percent=Good./Group_Count;%��ģʽ��������
total=sum(Good)/sum(Group_Count);%��������


