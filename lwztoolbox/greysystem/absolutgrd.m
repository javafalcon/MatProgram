function r = absolutgrd(x,y)
%����x,y֮��Ļ�ɫ���Թ�����
n = length(x);
x = x - x(1);
y = y - y(1);
Sx = abs( sum(x) - 0.5*x(n));
Sy = abs( sum(y) - 0.5*y(n));
S = abs(sum((x-y)) - 0.5*((x(n) - y(n))));
r = (1 + Sx + Sy)/(1 + Sx + Sy + S);
