% 相似灰色关联度模型
% SimilarGID(x,y)计算序列x,y之间的接近灰色关联度
function p = SimilarGID(x,y)
n = length(x);
z=(x-x(1))-(y-y(1));
u = sum( z(2:n-1)) + 0.5*z(n);
p = 1/(1+abs(u));