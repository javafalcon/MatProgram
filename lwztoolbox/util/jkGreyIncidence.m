%Author:Lin Wei-Zhong
%Date:2008-1-11
%Version:1.2
%[Percent,Total]=jkGreyIncidence(Vector_Group,Group_Count,k)
%函数功能描述：对cell型变量Vector_Group进行jack-knife测试，距离使用灰色关联度，算法为k近邻算法
%Vector_Group:测试数据集
%Group_Count:每类数据集包含序列的个数
%k:近邻数
%Percent:每类的预测正确率
%Total:总预测正确率
function [Percent,Total]=jkGreyIncidence(Vector_Group,Group_Count,k)
type = length(Group_Count);
Good=zeros(1,type);
%dim =length(Vector_Group{1}{1});
te = sum(Group_Count);
tn = AGO(Group_Count);
%把Vector_Group转换为矩阵
T=[];
for i = 1:type
    mat = CellToMatrix(Vector_Group{i});
    T = [T; mat];
end

for i=1:te
    x=T(i,:);%待识别模式的元素
    %待识别的元素本该属于模式t1
    t1 = 1;
    while ( ( i > tn(t1) ) && ( t1 < type) )
        t1 = t1 + 1;
    end
    %jack-knife测试
    knn = zeros(1,type);
    S = T;
    S(i,:) = [];%去掉测试向量T(i,:)
    cot = Group_Count;
    cot(t1) = cot(t1) -1;%模式t1的元素个数减1
    tnn = AGO(cot);
    r=GreyIncidenceDegree(S,x);%x与S所有元素的灰色关联度
%     r = CosinDistance(S,x);
    %r = EuclDistance(S,x);
    %从灰色关联度序列r中找出最大值的下标inx
    [B,IX]=sort(r);
    kinx = IX(te-k:te-1);
    %统计每一类的近邻数
    for ii = 1:k
        t2=1;
        %把kinx(ii)划分到模式t2
        while (( kinx(ii) > tnn(t2)) && (t2 < type))
            t2=t2+1;
        end
        %模式t2的近邻数加1
        knn(t2) = knn(t2) + 1;
    end
    %哪一类含近邻最多
    [val,I] = max(knn);
    if I == t1
        Good(t1) = Good(t1) + 1;
    end
end
Total=sum(Good)/te;
Percent=Good./Group_Count;
        
        
        