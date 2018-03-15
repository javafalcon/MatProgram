%This is an examplar file on how the ML-RBF program could be used (The main function is "ML_RBF_train.m" and "ML_RBF_test.m")
%
%Type 'help ML_RBF_train' and 'help ML_RBF_test' under Matlab prompt for more detailed information


% Loading the file containing the necessary inputs for calling the ML-RBF function
load('sample data.mat'); 

%Set parameters for the ML-RBF algorithm
ratio=0.01;% Set the alpha parameter
mu=1; % Set the mu parameter

% Calling the main functions
[Centroids,Sigma_value,Weights,tr_time]=ML_RBF_train(train_data,train_target,ratio,mu); % Invoking the training procedure

[HammingLoss,RankingLoss,OneError,Coverage,Average_Precision,Outputs,Pre_Labels,te_time]=ML_RBF_test(test_data,test_target,Centroids,Sigma_value,Weights); % Performing the test procedure