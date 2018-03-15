function R =GIDistance(y,X,p)
% GreyIncidenceDegree Compute grey incidence degree
%   R=GreyIncidenceDegree compute the grey incidence degree with y and each
%   row in X. y is a 1-by-n row vector. X is a mx-by-n matrix.
%   
%   Input:
%       y   -A 1-by-n row vector
%       X   -A my-by-n matrix
%
%   Ouput:
%       R   -A mx-by-1 vector of grey incidence degree, whose j-th element
%       is the grey incidence degree between y and X(j,:)

    if nargin < 3
        p = 0.5;
    end
    
    [m,n] = size(X);
    D = zeros(m,n);%
    z = zeros(m,n);%
    R = zeros(m,1);
    
    for k = 1:m
        D(k,:)=abs(y-X(k,:));
    end
    dmin = min(min(D));
    dmax = max(max(D));
    
    for i = 1:m
        for j = 1:n
            z(i,j) = (dmin + p*dmax)/(D(i,j)+p*dmax);
        end
    end
    
    for i = 1:m
          R(i) = 1-sum(z(i,:))/n;
    end
