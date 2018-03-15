function val = rbf(u,v,g)
if nargin < 3
    g = 1;
end
val = exp(-g * ( norm(u-v)^2));
%kval = exp(-(1/(2*sigma^2))*(repmat(sqrt(sum(u.^2,2).^2),1,size(v,1))...
%    -2*(u*v')+repmat(sqrt(sum(v.^2,2)'.^2),size(u,1),1)));
%val = exp(-g*(repmat(sqrt(sum(u.^2,2).^2),1,size(v,1))...
 %   -2*(u*v')+repmat(sqrt(sum(v.^2,2)'.^2),size(u,1),1)));