%[percent,yotal,PM]=independ_gid(S,T,m,si,ti,K)
%S:训练集，矩阵类型。S=S1US2US3U...USm
%T:测试集，矩阵类型。T=T1UT2UT3U...UTm
%m:模式数
%k:KNN算法的窗口参数K
%sindex:训练集各类包含元素的数目
%tindex:测试集各类包含元素的数目
%函数功能：用基于灰色关联度的最近邻算法(KNN)对测试集Y分类预测。得出各类正确的识别率和总的识别率。
function [percent,total,PM]=independ_gid(Learn,Test,type,Learn_Count,Test_Count,n)
    Good=zeros(1,type);
    PM = zeros(type,type);%判别矩阵。PM(i,j)表示把i类判为j类
    S=[];
    for i=1:type
        M=CellToMatrix(Learn{i});
        S=[S;M];
    end
    si = AGO(Learn_Count);
    for i=1:type
        for j=1:Test_Count(i)
            x=Test{i}{j};%待判别类属的向量，本应该属于第i类
            %r=GreyIncidenceDegree(S,x');
            r = CosinDistance(S,x');
            [C,IX]=sort(r,'descend');%对关联度降序排列，前k个为关联度最大。
            vote = zeros(1,type);
            for k = 1:n
                %K近邻法
                knn = zeros(1,type);%记录每一类的近邻数
                for t=1:k
                    m=1;
                    while( IX(t) > si(m) ) 
                        m=m+1;
                    end
                    knn(m) = knn(m)+1;%把IX(t)归为m类
                end
                [val,kind] = max(knn);%含近邻数最多的模式是kind类，即把本属于第i类的向量x判为第kind类。
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
            
            
        
