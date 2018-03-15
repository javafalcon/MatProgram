%GPCR预测器
%t = GPCRpredictor(x,s,Group_Count,k)
%x:待预测的蛋白质.是行向量
%S:训练集矩阵.S=S1US2U...USm。每行代表一个蛋白质样本序列。
%Group_Count:各个子集Si的样本数
%m:子集个数.
%K:近邻数
%t:返回值，预测x属于St子集
function t = GKNNpred(x,S,Group_Count,m,K)
%用KNN算法结合灰色关联度
R = GreyIncidenceDegree(S,x);
si = AGO(Group_Count);
[C,IX]=sort(R,'descend');%对关联度降序排列。
knn = zeros(1,m);%记录每一类的近邻数
for t = 1:K
    m=1;
    while( IX(t) > si(m)) 
        m=m+1;
    end
    knn(m) = knn(m)+1;%把IX(t)归为m类
end
[val,t] = max(knn);%含近邻数最多的模式是kind类，即把x判为第t类。