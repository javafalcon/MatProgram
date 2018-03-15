%k近邻算法。jack knife测试
%Vector_Group是样本集，包含了m个模式
%Group_Count：每个模式的序列数
%knum:近邻数
function [percent,total,PM] = jk_knn(Vector_Group,Group_Count,knum,dist)
type = length(Vector_Group);%type模式数
PM = zeros(type,type);%判别矩阵。PM(i,j)表示把i类判为j类

%把cell变量Vector_Group转换为矩阵，每个序列作为矩阵的行向量
S=[];
for i=1:type
    M=CellToMatrix(Vector_Group{i});
    S=[S;M];
end

%jackknife测试
n = 1;
m = sum(Group_Count) - 1;
for i = 1:type
    for j = 1:Group_Count(i)
        x = Vector_Group{i}{j}';
        
        R = S;
        R(n,:)=[];%把x排除
        gc = Group_Count;
        gc(i) = gc(i) - 1;%相应地第i类的向量个数减1
        
        %计算x和R中每个向量的距离
        d = zeros(1,m);
        switch dist
            case {'cosin'}
                for ii = 1:m
                    y = R(ii,:);%R的第i行向量
                    d(ii) = CosAngleDistance(x,y);%余弦距离
                end
            case {'minkowski'}
                for ii = 1:m
                    y = R(ii,:)
                    d(ii) = MinkowskiDistance(x,y,1);%明氏距离
                end
            case {'gid'}
                d = GreyIncidenceDegree(R,x);
        end
        
        [C,IX]=sort(d,'descend');%对距离降序排列。
        
        %k近邻算法。IX中的前k个值归类
        si = AGO(gc);
        knnv = zeros(1,type);%记录每一类的近邻数
        for t = 1:knum
            f=1;
            while( IX(t) > si(f) ) 
                f = f + 1;
            end
            knnv(f) = knnv(f) + 1;%把IX(t)归为f类
        end
        [val,kind] = max(knnv);%含近邻数最多的模式是kind类，即把x判为第kind类。
        
        PM(i,kind) = PM(i,kind) + 1;%把第i类的序列判断为第kind类
        
        n=n+1;
    end
end

Good=zeros(1,type);%正判的个数
for i = 1:type
    Good(i) = PM(i,i);
end
percent=Good./Group_Count;%各模式的正判率
total=sum(Good)/sum(Group_Count);%总正判率


