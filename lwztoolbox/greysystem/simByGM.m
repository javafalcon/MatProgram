function y=simByGM(x,k)
if k == 1
    y = x(1);
else
    P=GMParam(x);
    a=P(1);
    b=P(2);
    init=x(1);
    y = (1-exp(a))*(init - b/a)*exp(-a*(k-1));
end
    
