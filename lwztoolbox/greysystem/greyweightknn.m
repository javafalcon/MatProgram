function labels = greyweightknn(data,samples,groups,k)
n = size(data,1);
labels = size(n,1);
type = max(groups);
p = greyweight(samples,groups);
for i = 1 : n
    x = data(i,:);
    r = GreyIncidenceDegree(x,samples);
    [B,IX] = sort(r,'descend');
    dist = zeros(1,type);
    for j = 1 : type
        for kk = 1 : k
            dist(j) = dist(j) + B(k) * p(IX(k),j);
        end
    end
    [C,I] = max(dist);
    labels(i,1) = I;
end
    
    