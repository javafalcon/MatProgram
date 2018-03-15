function K=simgrd_kernel(U,V)
%GIA_KERNEL similar grey incidence degree kernel for SVM functions

% AUTHOR Wei-Zhong Lin
% DATE 2010-9-13
[m1,n1] = size(U);

[m2,n2] = size(V);
if n2 ~= n1
    erro('have errro');
end
K1=zeros(m1,m2);
K0 = zeros(m1,m2);

for i = 1:m1
    for j = 1:m2
        u = U(i,:);
        v = V(j,:);
        
        u0 = u - u(1);
        v0 = v - v(1);
        
        K1(i,j) = 1 / ( 1 + (u-v)*(u-v)');
        K0(i,j) = 1/ ( 1 + (u0-v0)*(u0-v0)');
    end
end

w = 1;
K = w*K1 + (1-w)*K0;
