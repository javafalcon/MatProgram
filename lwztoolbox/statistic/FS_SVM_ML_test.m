function FS_SVM_ML_test(trnmodel, Y, X)
% Multi-Label classifier testing function
% trnmodel is a struct array, for each element of cell:
%   indx  --is the index of features selecting
%   model --is the svm training model by using libsvm

    [N,Q] = size(Y);
    
    Y_hat = zeros(N, Q);

    for q = 1 : Q
        Y_hat(:,q) = svmpredict(Y(:,q), X(:,trnmodel(q).indx), trnmodel(q).model);
%         Y_hat(:,q) = svmpredict( Y(:,q), X, trnmodel(q).model); 
    end
    
%% measure the performance
    Pre_Labels = (Y_hat' -0.5)*2;
    y = (Y' - 0.5)*2;
    HammingLoss = Hamming_loss(Pre_Labels,y);
    SubsetAccuracy = SubsetAcc(Pre_Labels,y);
    Precision = MLPrecision(Y, Y_hat);
    Recall = MLRecall(Y, Y_hat);
        
    %% output prediction performance
    fprintf('HammingLoss=%6.4f\n', HammingLoss);
    fprintf('SubsetAccuracy=%6.4f\n', SubsetAccuracy);
    fprintf('Precision=%6.4f\n', Precision);
    fprintf('Recall=%6.4f\n', Recall);