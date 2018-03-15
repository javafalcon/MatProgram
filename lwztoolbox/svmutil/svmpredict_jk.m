function [predict_label,accuracy,dec_values]=svmpredict_jk(label,data,option,fold)

row = size(data,1);
predict_label = zeros(row,1);
dec_values = zeros(row,1);
indices=crossvalind('Kfold',label,fold);
for i = 1 : fold
    train=true(row,1);
    train(indices==i)=false;
    test=~train;
    model=svmtrain(label(train),data(train,:),option);
    [predict_label(test),accu, dec_values(test)] = svmpredict(label(test),data(test,:),model);
end
accuracy = (sum(predict_label==label)/row);