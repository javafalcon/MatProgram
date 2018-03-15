function y = simByRNIGM(x,k)
    P = RNIGMP(x);
    x1 = AGO(x);
    n = length(x);
    y = ( x1(n) - P(2)/P(1) ) * ( 1 - exp( P(1) )) * exp( P(1)*(n-k));
   
    