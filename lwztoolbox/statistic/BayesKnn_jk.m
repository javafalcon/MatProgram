function Y_pred = BayesKnn_jk(XT,YT,K,S)
% BayesKnn_jk(XT,YT) jackkife test in dataset XT with labelset YT
N= size(YT,1);
Y_pred = zeros(N,1);
for i = 1 : N
    disp(strcat('Testing', ' ',int2str(i),'-th instance'));
    Test_X = XT(i,:);
    indx = true(N,1);
    indx(i) = false;
    Train_X = XT(indx,:);
    Train_Y = YT(indx);
    %% SMOTE imbalance data
%     idx_pos = Train_Y==1;
%     ptr = Train_X(idx_pos,:);
%     ntr = Train_X(~idx_pos,:);
%     [posData, negData] = BiSmote(ptr, ntr, K, 3);
%     data = [posData; negData];
%     group = [ones(size(posData,1),1); zeros(size(negData,1),1)];
    %%
    postprob = BayesKnn_train(Train_X, Train_Y, K, S);
%     posPr = size(ptr,1)/(size(ptr,1)+size(ntr,1));
%     negPr = 1 - posPr;
    [ Y_pred(i), Pred_R ] = BayesKnn_test( Test_X, Train_X, Train_Y, postprob, K);
end