function GFaLK_SVM_nf(data,group,n)
row = size(data,1);
% correctCount = 0;
indices = crossvalind('Kfold',row,n);
correctCount = 0;
for i = 1 : n
    test = (indices==i);
    train = ~test;
    [models,modelPtrs]=GFaLK_SVM_train(data(train,:),group(train),131,131);
    predLabel = GFaLK_SVM_test(data(train,:),modelPtrs,models,data(test,:));
    z = predLabel - group(test);
    correctCount = correctCount + sum( z==0);
end
fprintf('predict correctNums: %f\n CorrectRate=%f\n', correctCount,correctCount/row);