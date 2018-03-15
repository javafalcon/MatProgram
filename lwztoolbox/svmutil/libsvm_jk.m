function rate = libsvm_jk(label,instance,  option)
n = length(label);
right = 0;
for i = 1 : n
    train = true(n,1);
    train(i) = false;
    model = svmtrain(label(train), instance(train,:), option);
    [predict_label, accuracy, dec_values] = svmpredict(label(~train), instance(~train,:), model);
    if predict_label == label(~train)
        right = right + 1;
    end
end
rate = right/n;
        