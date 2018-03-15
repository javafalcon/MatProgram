function Y_hat = FS_DL_ML_test( model, x, y )
% Multi-Label classifier testing function

    N = size(x, 1);
    Q = size(y, 2);

    Y_hat = zeros(N, Q);

    for q = 1 : Q
        Y_hat(:,q) = nnpredict( model(q).nn, x);
    end
    Y_hat = Y_hat - 1;
%% measure the performance
    Pre_Labels = (Y_hat' -0.5)*2;
    Y = (y' - 0.5)*2;
    HammingLoss = Hamming_loss(Pre_Labels,Y);
    SubsetAccuracy = SubsetAcc(Pre_Labels,Y);
    Precision = MLPrecision(y, Y_hat);
    Recall = MLRecall(y, Y_hat);
        
    %% output prediction performance
    fprintf('\\neighbors=%d\n',k);
    fprintf('HammingLoss=%6.4f\n', HammingLoss);
    fprintf('SubsetAccuracy=%6.4f\n', SubsetAccuracy);
    fprintf('Precision=%6.4f\n', Precision);
    fprintf('Recall=%6.4f\n', Recall);


end

