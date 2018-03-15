function GFaLK_SVM_jk(data,group)
row = size(data,1);
correctCount = 0;

for i = 1 : row
    test = false(row,1);
    test(i) = true;
    train = ~test;
    [models,modelPtrs]=GFaLK_SVM_train(data(train,:),group(train),31,31);
    predLabel = GFaLK_SVM_test(data(train,:),modelPtrs,models,data(test,:));
    if predLabel == group(i)
        correctCount = correctCount + 1;
    end
end
fprintf('predict correctNums: %f\n CorrectRate=%f\n', correctCount,correctCount/row);