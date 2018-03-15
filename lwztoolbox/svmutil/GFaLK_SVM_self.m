function GFaLK_SVM_self(data,group)
row = size(data,1);
correctCount = 0;

[models,modelPtrs] = GFaLK_SVM_train(data,group,23,17);
for i = 1 : row
    x = data(i,:);
    predLabel = GFaLK_SVM_test(data,modelPtrs,models,x);
    if predLabel == group(i)
        correctCount = correctCount + 1;
    end
end
fprintf('predict correctNums: %f \n CorrectRate=%f\n', correctCount,correctCount/row);