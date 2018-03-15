function a = OptBackGMParam(x)

% OptBackGMParam  利用优化的背景值建模GM(1,1),求解其参数

n = length(x);

z = zeros(n,1);
Y = zeros(n-1,1);

% 背景值的优化
for k = 2 : n
    if ( x(k) == x(k-1))
        z(k) = x(k);
    else
%         z(k) = ( x(k)/(log( x(k)) -log( x(k-1)))) + power( x(k-1),k)/( power( x(k),k-2) * ( x(k-1) - x(k)));
       z(k) = ( x(k)/(log( x(k)) -log( x(k-1)))) + power( x(k-1)/x(k),k-2)* (x(k-1)*x(k-1)/( x(k-1) - x(k))); 
    end
end

B = ones(n-1,2);
B(:,1) = -z(2:n);

for i = 2 : n
    Y(i-1) = x(i);
end

a = inv( B'*B) * B'* Y;


