%author:linweizhong.2007-7-21
function P=GMParam(x)
    n=length(x);
    X1=zeros(1,n);
    X1(1) = x(1);
    for i=2:n
        X1(i) = X1(i-1) + x(i);
    end
    
    Z=zeros(1,n);
    for i=2:n
        Z(i) = 0.5*(X1(i) + X1(i-1));
    end

    B=zeros(n-1,2);
    for k=1:n-1
        B(k,1) = -Z(k+1);
        B(k,2) = 1;
    end
    
    Y=zeros(n-1,1);
    for k=1:n-1
        Y(k) = x(k+1);
    end
    
    a=inv(B'*B)*B'*Y;
    
    C = 0;
    for i=2:n
        C = C + Z(i);
    end
    
    E = 0;
    for i=2:n
        E = E + Z(i)*x(i);
    end
    
    D = 0;
    for i=2:n
        D = D + x(i);
    end
    
    F = 0;
    for i=2:n
        F = F + Z(i)^2;
    end
    
    P = zeros(1,6);
    P(1) = a(1); P(2) = a(2);
    P(3) = C; P(4) = D; P(5) = E; P(6) = F;