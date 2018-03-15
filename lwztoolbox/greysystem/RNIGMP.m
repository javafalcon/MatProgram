%Reform New Information Grey Model Parameter
function P = RNIGMP(x)
    x1 = AGO(x);
    n = length(x);
    z = zeros(1,n);
    for k = 2:n
        z(k) = 0.5*( x1(k) + x1(k-1) );
    end
    
    a = 0;
    b = 0;
    for k = 2:n
        a = a + z(k)^2;
        b = b + z(k);
    end
    D = (n-1)*a - b^2;
    
    P = zeros(1,2);
    for k = 2:n
        P(1) = P(1) + x(k)*( b - (n-1)*z(k));
        P(2) = P(2) + x(k)*( a - z(k)*b);
    end
    P(1) = P(1)/D;
    P(2) = P(2)/D;
    