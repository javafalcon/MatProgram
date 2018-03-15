function rate = gidknnjk(data,group,k)
row = size(data,1);
type = max(group);
indices = 1:row;
predLabel = zeros(row,1);
for i = 1 : row
    test = (indices == i);
    train = ~test;
    label = group(train);
    r = GreyIncidenceDegree(data(test,:),data(train,:));
    [B,IX] = sort(r,'descend');
    d = zeros(1,type);
    for j = 1 : k
        d( label( IX(j))) = d( label( IX(j))) + 1;
    end
    [C,I] = max(d);
    predLabel(i) = I;
end
rate = sum(predLabel==group)/row;