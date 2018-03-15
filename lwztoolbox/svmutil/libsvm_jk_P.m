function rate = libsvm_jk_P(label,K)
row = length(label);
right = 0;
for i = 1 : row
    train = true(row,1);
    train(i) = false;
    test = ~train;
    model = svmtrain(label(train), [(1:row-1)',K(train,train)], '-t 4');
    [predict_label, accuracy, dec_values] = svmpredict(label(test), [1,K(test,train)], model);
    if predict_label == label(test)
        right = right + 1;
    end
end
rate = right/row;


