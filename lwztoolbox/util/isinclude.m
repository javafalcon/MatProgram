function f=isinclude(X,x)
%元素x是否在序列X中，在返回1，否则返回0
n=length(X);
f=0;
for i=1:n
    if x==X(i)
        f = 1;
        break;
    end
end