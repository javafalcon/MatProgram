function predict=jksvmpredictor(data,groups)
len = length(groups);
correctNum = 0;
for i = 1 : len
    test=logical(zeros(len,1));
    test(i)=true;
    train=~test;
    svmStruct = svmtrain(data(train,:),groups(train));
    classes = svmclassify(svmStruct,data(test,:));
    if classes == groups(i)
        correctNum = correctNum + 1;
    end
end

predict=correctNum/len;
