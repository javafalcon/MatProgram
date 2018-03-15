function K = precomputekernel(data,p)
[row,col]=size(data);
K = zeros(row,row);
for i = 1 : row
    for j = 1 : row
        K(i,j) = (1-p)*SimilarGID(data(i,:), data(j,:)) + p*NearestGID(data(i,:),data(j,:));
%         K(i,j) = NearestGID(data(i,:),data(j,:));
        K(j,i) = K(i,j);
    end
end

