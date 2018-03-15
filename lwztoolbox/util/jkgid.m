%用灰色关联度作为距离函数对Vector_Group用jack-knife方法预测
%Vector_Group:cell(1,n)n个模式的向量。其中，Vector_Group{i}是cell(1,ni)型，表示i类模式中有ni个向量
%Group_Count:每类模式含向量的个数
%type:模式数
%k:近邻数
function [percent,total,PM]=jkgid(Vector_Group,Group_Count,type,num)
    Good=zeros(1,type);
    PM = zeros(type,type);%判别矩阵。PM(i,j)表示把i类判为j类
    S=[];
    for i=1:type
        M=CellToMatrix(Vector_Group{i});
        S=[S;M];
    end
    
    n = 1;
    for i=1:type
        for j=1:Group_Count(i)
            x=Vector_Group{i}{j};%待判别类属的向量，本应该属于第i类
            R=S;
            R(n,:)=[];%把x排除
            r=GreyIncidenceDegree(R,x');
            gc=Group_Count;
            gc(i)=gc(i)-1;%相应地第i类的向量个数减1
            si=AGO(gc);
            [C,IX]=sort(r,'descend');%对关联度降序排列，前k个为关联度最大。
            
            vote = zeros(1,type);
            for k=1:num
                %K近邻法
                knn = zeros(1,type);%记录每一类的近邻数
                for t=1:k
                    m=1;
                    while( IX(t) > si(m)) 
                        m=m+1;
                    end
                    knn(m) = knn(m)+1;%把IX(t)归为m类
                end
                [val,kind] = max(knn);%含近邻数最多的模式是kind类，即把本属于第i类的向量x判为第kind类。
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
            
            
        
