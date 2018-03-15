function K=agid_kernel(U,V)
%GIA_KERNEL absolute grey incidence degree kernel for SVM functions

% AUTHOR Wei-Zhong Lin
% DATE 2010-9-8
[m1,n1] = size(U);

[m2,n2] = size(V);
if n2 ~= n1
    erro('have errro');
end
K=zeros(m1,m2);

for i = 1:m1
    for j = 1:m2
        u = U(i,:);
        v = V(j,:);

        u = u - u(1);
        v = v - v(1);
        S0 = 0; S1 = 0; S3 =0;
        for i = 1 : n1-1
            S0 = S0 + u(i);
            S1 = S1 + v(i);
            S3 = S3 + ( u(i) - v(i));
        end

        S0 = S0 + u(n1)/2;
        S1 = S1 + v(n1)/2;
        S3 = S3 + ( u(n1) - v(n1))/2;

        S0 = abs(S0);
        S1 = abs(S1);
        S3 = abs(S3);

        K(i,j) = ( 1 + S0 + S1) / ( 1 + S0 + S1 + S3);
    end
end
