%对样本sample使用knn算法进行jack knife测试
%sample:样本集.n行m列的数组，n表示样本数目，m表示每个样本向量的维数.
%group:每个样本对应的模式
%s：将样本集随机划分为s个子集
%k：近邻数
function [good,total] = gidknnjackknife(sample,group,s,k)

[n,m]=size(sample);
good = zeros(1,s);
for i = 1:n
    target = sample(i,:);
    y = sample;
    y(i,:) = [];
    type = gidknnclassify(target,y,group,k);
    if type == group(i)
        good(type) = good(type) + 1;
    end
end
total = sum(good)/n;