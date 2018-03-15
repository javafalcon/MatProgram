function kfval =  kfda_jk(data,group)
row = size(data,1);
k = zeros(row,1);
fun = @rbf;

kfval = K * w;

for i = 1 : row
    train = true(row,1);
    train(i) = false;
    test =~ train;
    trainData = data(train,:);
    [w,K] = kernelfisher( trainData, group(train));
    fval = K*w;
    m = mean(fval);
    f = 0;
    for j = 1 : length(w)
       f = f + w(j)*fun( data(test),:),trainData(j));