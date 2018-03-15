function Y_pred = fknnml_independent_test(trnX, trnY, tstX, tstY, varargin)
% 根据参数k,m计算ML-FKNN的LOO成功率
%
% instance:    样本矩阵，每行代表一个样本的特征向量
% label:       样本类标签集合，与instance行对应
%         ClassA  ClassB  ClassC ...
%      S1   1       0       1    ...
%      S2   1       1       0    ...
%      ...

    pnames = {'K','MDW','SMOTE','Amount', 'Snn', 'Loop', 'LN', 'Distance'};
    dflts = {21,2,true,3,7,false,10,'euclidean'};
    [k,m,smote,amount,snn,loop,ln,distfun] = internal.stats.parseArgs( pnames, dflts, varargin{:});

    [N, C] = size(tstY);
    
    Y_pred = zeros(N, C);
    if smote
        [synX, synY] = MLSMOTE( trnX,trnY,'Amount',amount,'K', snn, 'Loop', loop, 'LN', ln, 'Distance', distfun);
    else
        synX = trnX;
        synY = trnY;
    end
    %% independent test
    for s = 1:N
        disp(s);
        Y_pred(s,:) = fknnml(synX,synY,tstX(s,:),k,m,distfun);
    end

%% measure the performance
    Y_hat = (Y_pred' - 0.5)*2;
    Y = (tstY' - 0.5)*2;
    HammingLoss = Hamming_loss(Y_hat,Y);
    SubsetAccuracy = SubsetAcc(Y_hat,Y);
    Precision = MLPrecision(tstY, Y_pred);
    Recall = MLRecall(tstY, Y_pred);
       
    %% output prediction performance
    fprintf('\\neighbors=%d\n',k);
    fprintf('HammingLoss=%6.4f\n', HammingLoss);
    fprintf('SubsetAccuracy=%6.4f\n', SubsetAccuracy);
    fprintf('Precision=%6.4f\n', Precision);
    fprintf('Recall=%6.4f\n', Recall);
    
end

