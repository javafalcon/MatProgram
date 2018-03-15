function Y=Verhulst(X)
n=length(X);
Y=zeros(1,n);
Y(1)=X(1);
[a,b]=VerhulstParam(X);
m = a*X(1);
n = b*X(1);
p = a - m;
for k=1:n-1
    Y(k+1)=m/(n+p*exp(a*k));
end