%������x,��m��СƬ�ι���BP������ѵ����P��Ŀ�꼯T
function [P,T]=PTSet(x,m)
n=length(x);
P = zeros(m,n-m);
T = zeros(1,n-m);
col = 0; %����
row = 0; %����
k = 1;
for col = 1:n-m
    for row = 1:m
        P(row, col) = x(k);
        k = k+1;
    end
    T(k-m) = x(k);
    k = k - m +1;
end