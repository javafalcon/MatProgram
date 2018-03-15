%求序列x的累加生成序列(Accumulated Generation Operation)
function y=AGO(x)
    n=length(x);
    y=zeros(1,n);
    y(1) = x(1);
    for i=2:n
        y(i) = y(i-1) + x(i);
    end