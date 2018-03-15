function [a,b]=VerhulstParam(X)
n=length(X);
X1=AGO(X);
Z=zeros(1,n);
for i=2:n
    Z(i)=0.5*(X1(i)+X1(i-1));
end

B=zeros(n-1,2);
for i=1:n-1
    B(i,1)=-Z(i+1);
    B(i,2)=Z(i+1)^2;
end

Y=zeros(n-1,1);
for i=1:n-1
    Y(i)=X(i+1);
end

p=inv(B'*B)*B'*Y;
a=p(1);b=p(2);

    