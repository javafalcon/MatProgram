function [HammingLoss, RankingLoss, OneError, Coverage, Average_Precision, Outputs, Pre_Labels]=ML_RBF_jk(train_data,train_target,ratio,mu)
%   Description
%
%       ML_RBF_jk takes,
%           train_data    - An MxN array, the i-th training instance is stored in train_data(i,:)
%           train_target  - A QxM array, if the i-th training instance belongs to the jth class, then train_target(j,i) equals +1, otherwise train_target(j,i) equals -1
%           ratio         - The number of centroids of the i-th class is set to be ratio*Ti, where Ti is the number of training instances with lable i
%           mu            - The ratio used to determine the standard deviation of the Gaussian activation function [1]
%      and returns,
%           HammingLoss       - The hamming loss on testing data
%           RankingLoss       - The ranking loss on testing data
%           OneError          - The one-error on testing data
%           Coverage          - The coverage on testing data
%           Average_Precision - The average precision on testing data
%           Outputs           - A QxM array, the probability of the i-th testing instance belonging to the j-th class is stored in Outputs(j,i)
%           Pre_Labels        - A QxM array, if the i-th testing instance belongs to the jth class, then Pre_Labels(j,i) is +1, otherwise Pre_Labels(j,i) is -1

    [Q, M] = size(train_target);
    Outputs = zeros(Q, M);
    Pre_Labels = zeros(Q, M);
    for i = 1 : M
        disp(strcat('Testing ', int2str(i), '-th instance ......'));
        ind = true(M,1);
        ind(i) = false;
        TrainX = train_data(ind,:);
        TrainY = train_target(:,ind);
        TestX = train_data(i,:);
        TestY = train_target(:,i);
        [Centroids,Sigma_value,Weights,~]=ML_RBF_train(TrainX,TrainY,ratio,mu); % Invoking the training procedure
        [~,~,~,~,~,Outputs(:,i),Pre_Labels(:,i),~]=ML_RBF_test(TestX,TestY,Centroids,Sigma_value,Weights); % Performing the test procedure
    end
    
    HammingLoss=Hamming_loss(Pre_Labels,test_target);
    RankingLoss=Ranking_loss(Outputs,test_target);
    OneError=One_error(Outputs,test_target);
    Coverage=coverage(Outputs,test_target);
    Average_Precision=Average_precision(Outputs,test_target);