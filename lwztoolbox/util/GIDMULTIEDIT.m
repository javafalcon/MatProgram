%重复剪辑最近邻MULTIEDIT算法
%sample:样本集.n行m列的数组，n表示样本数目，m表示每个样本向量的维数.
%s：将样本集随机划分为s个子集
%k：近邻数
function [v,g]=GIDMULTIEDIT(sample,group,s,k)
y = sample;
edit = 1;
while edit > 0
    [n,m]=size(y);
    %构造s个子集
    x = cell(1,s);
    xgroup = cell(1,s);
    %step 1: 将样本集随机地划分为s个子集
    %1.1 产生1~N的随机数
    r = randperm(n);
    %1.2 将样本集按得到随机数顺序重新排列
    y = y(r,:);
    group = group(r);
    
    step = round(n/s);
    low = 1;
    high = low + step - 1;

    i = 1;
    while i < s
        x{i}=y(low : high,:);
        xgroup{i}=group(low:high);
        low = high + 1;
        high = low + step - 1;
        i = i + 1;
    end
    x{s} = y(low : n,:);
    xgroup{s}=group(low:n);
    
    %step 2: 用最近邻法，以x{(i+1)mods}为参照集，对x{i}中的样本分类，其中i=1,2,...,s;
    edit = 0;
    for i = 1 : s
        tn = size(x{i},1);%计算x{i}中样本数量
        e = [];%错分的样本序号
        r = i +1;
        if r > s
            r = 1;
        end
        for j = 1 : tn
            %识别x{i}(j,:)的类别
            type = gidknnclassify(x{i}(j,:), x{r}, xgroup{r}, k);
            
            %记下被错分的样本
            if type ~= xgroup{i}(j);
                e=[e j];
                edit = edit + 1;
            end
        end
        %step 3: 去掉被错误分类的样本
        x{i}(e,:) = [];
        xgroup{i}(e) = [];
    end
 
    %step 4: 用所留下的样本构成新的样本集y；
    y=[];
    group=[];
    for i=1:s
        y=[y;x{i}];
        group=[group xgroup{i}];
    end

    %step 5: 回到step 1直道没有样本被剪辑掉。当edit = 0时退出算法.

end
v = y;
g = group;








