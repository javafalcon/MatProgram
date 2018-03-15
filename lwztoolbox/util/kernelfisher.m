function [w,K] = kernelfisher(data,group,dim,fun)
%data两类的数据，前l1个是第1类，后l2个是第2类
%默认的核函数是径向量机函数exp(-r*||X-Y||^2)
if (nargin < 2)
    error('Too little parameter');
end
if nargin == 2
    dim = 1;
end
if (nargin < 4)
    fun = @rbf;
    g = 1/(2^6);
end

row = size(data,1);
count = zeros(1,2);
for i = 1 : row
    switch group(i)
        case -1
            count(1,1) = count(1,1) + 1;
        case 1
            count(1,2) = count(1,2) + 1;
    end
end
M = zeros(row,1,2);

K = zeros(row,row);
for i = 1 : row
    for j = 1 : row
        K(i,j) = fun(data(i,:), data(j,:),g);
    end
end

M(:,1,1) = mean( K( :, 1:count(1,1)), 2);
M(:,1,2) = mean( K( :, count(1,1) + 1 : row), 2);

Sm = ( M(:,1,1) - M(:,1,2))*( M(:,1,1) - M(:,1,2))';

K1 = K(:,1:count(1,1));
K2 = K(:,count(1,1) + 1 : row);

I1 = ones(count(1,1), count(1,1))/count(1,1);
I2 = ones(count(1,2), count(1,2))/count(1,2);

N = K1 * ( eye(count(1,1), count(1,1)) - I1) * K1' + K2 * ( eye(count(1,2), count(1,2)) - I2) * K2';

[V, D] = eig(Sm, N);
diagElem = diag(D);
[B,IX] = sort(diagElem,'descend');
w = V(:,IX(1:dim));
w = orth(w);



% for i = 1 : row
%     for j = 1 : row
%         if group(j) == -1
%             M(i,1,1) = M(i,1,1) + fun(data(i,:),data(j,:),g);
%         elseif group(j) == 1
%             M(i,1,2) = M(i,1,2) + fun(data(i,:),data(j,:),g);
%         end
%     end
% end
% M(:,1,1) = M(:,1,1)/count(1,1);
% M(:,1,2) = M(:,1,2)/count(1,2);

% K1 = zeros(row,count(1,1));
% K2 = zeros(row,count(1,2));
% for i = 1 : row
%     for j = 1 : count(1,1)
%         K1(i,j) = fun( data(i,:),data(j,:),g);
%     end
%     for j = 1 : count(1,2)
%         K2(i,j) = fun( data(i,:),data( j + count(1,1), :),g);
%     end
% end

