function p=greyweight(samples,groups)
%
m = size(samples,1);
type = max(groups);
p = zeros(m, type);
gidmatrix = zeros(m,m-1);
indices = 1 : m;
for i = 1 : m
    extract = (indices == i);
    data = samples(~extract,:);
    label = groups(~extract);
    gidmatrix(i,:) = GreyIncidenceDegree(samples(i,:),data);
    for k = 1 : m-1
        p(i, label(k)) = p(i,label(k)) + gidmatrix(i,k);
    end
    p(i,:) = p(i,:)/sum(gidmatrix(i,:));
end


    
