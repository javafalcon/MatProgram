function MLMeasure( TY, Y_hat)
    %% measure the performance
    Pre_Labels = (Y_hat' -0.5)*2;
    Y = (TY' - 0.5)*2;
    HammingLoss = Hamming_loss(Pre_Labels,Y);
    SubsetAccuracy = SubsetAcc(Pre_Labels,Y);
    Precision = MLPrecision(TY, Y_hat);
    Recall = MLRecall(TY, Y_hat);
    RankingLoss=Ranking_loss(Pre_Labels,Y);
    OneError=One_error(Pre_Labels,Y);
    Coverage=coverage(Pre_Labels,Y);
    %% output prediction performance
    fprintf('HammingLoss=%6.4f\n', HammingLoss);
    fprintf('SubsetAccuracy=%6.4f\n', SubsetAccuracy);
    fprintf('Precision=%6.4f\n', Precision);
    fprintf('Recall=%6.4f\n', Recall);
    fprintf('RankingLoss=%6.4f\n', RankingLoss);
    fprintf('OneError=%6.4f\n', OneError);
    fprintf('Coverage=%6.4f\n', Coverage);
end
    