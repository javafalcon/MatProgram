function r = absolutgrd(x,y)
%计算x,y之间的灰色绝对关联度
n = length(x);
x = x - x(1);
y = y - y(1);
Sx = abs( sum(x) - 0.5*x(n));
Sy = abs( sum(y) - 0.5*y(n));
S = abs(sum((x-y)) - 0.5*((x(n) - y(n))));
r = (1 + Sx + Sy)/(1 + Sx + Sy + S);
