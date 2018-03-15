% 接近灰色关联度模型
% NearestGID(x,y)计算序列x,y之间的接近灰色关联度
function p = NearestGID(x,y)
n = length(x);
z=x-y;
u = sum( z(2:n-1)) + 0.5*(z(1) + z(n));
p = 1/(1+abs(u));