%对序列x,以m大小片段构建BP神经网络训练集P和目标集T
function [P,T]=PTSet(x,m)
n=length(x);
P = zeros(m,n-m);
T = zeros(1,n-m);
col = 0; %列数
row = 0; %行数
k = 1;
for col = 1:n-m
    for row = 1:m
        P(row, col) = x(k);
        k = k+1;
    end
    T(k-m) = x(k);
    k = k - m +1;
end