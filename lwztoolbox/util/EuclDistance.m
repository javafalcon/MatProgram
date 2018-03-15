
%计算向量P和集合S中每一个向量的距离
function d = EuclDistance(S,p)
m = size(S,1);
d = zeros(1,m);
for i = 1:m
    x = S(i,:);
    d(i) = dot(x-p,x-p);
end