%计算序列x的级比
function f = rankRatio(x)
n = length(x);
r = zeros(1,n);
for i = 2:n
    r(i) = x(i-1)/x(i);
end
a = exp(-2/(n+1));
b = exp(2/(n+1));
minv = min(r(2:n));
maxv = max(r(2:n));
if minv >= a && maxv <= b
    f = 1;
else
    f = 0;
end