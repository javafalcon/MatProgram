function P=GM21Param(X)
n=length(X);
X1=zeros(1,n);
X1(1) = X(1);
for i=2:n
    X1(i)=X1(i-1)+X(i);
end

Z=zeros(1,n);
for i=2:n
    Z(i) = 0.5*(X1(i) + X1(i-1));
end

B=zeros(n-1,3);
for k=1:n-1
    B(k,1) = -X(k+1);
    B(k,2) = -Z(k+1);
    B(k,3) = 1;
end

Y=zeros(n-1,1);
for k=1:n-1
    Y(k) = X(k+1) - X(k);
end

a = inv(B'*B)*B'*Y;

C = 0; D = 0; E = 0; F = 0; G = 0; H = 0; I = 0; L = 0;
for k=2:n
    C = C + X(k);
    D = D + X(k)^2;
    E = E + Z(k);
    F = F + Z(k)^2;
    G = G + X(k)*Z(k);
    H = H + X(k-1)*X(k);
    I = I + X(k-1)*Z(k);
    L = X(n) - X(1);
end

P(1) = a(1); P(2) = a(2); P(3) = a(3);
P(4) = C;    P(5) = D;    P(6) = E;
P(7) = F;    P(8) = G;    P(9) = H;
P(10) = I;   P(11) = L;