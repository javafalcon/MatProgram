function [Outputs,Y_pred] = MLKNN_jk( train_data,train_target,Num,Smooth )
%MLKNN_jk jack knife test a multi-label k-nearest neighbor classifier
%
%    Syntax
%
%       Y_pred=MLKNN_jk(train_data,train_target,num_neighbor)
%
%    Description
%
%       KNNML_train takes,
%           train_data   - An MxN array, the ith instance of training instance is stored in train_data(i,:)
%           train_target - A QxM array, if the ith training instance belongs to the jth class, then train_target(j,i) equals +1, otherwise train_target(j,i) equals -1
%           Num          - Number of neighbors used in the k-nearest neighbor algorithm
%           Smooth       - Smoothing parameter
%      and returns,
%           Y_pred        - A QxM array, if the ith training instance predicted to the jth class, then Y_pred(j,i)= 1, otherwise -1
  
    [num_class, num_training]=size(train_target);
    Y_pred = zeros(num_class, num_training);
    Outputs = zeros(num_class, numtraining);
    for i = 1 : num_training
        ind = true(num_training,1);
        ind(i) = false;
        train_X = train_data(ind,:);
        train_Y = train_target(:,ind);
        test_X = train_data(i,:);
        test_Y = train_target(:,i);
         
        [Prior,PriorN,Cond,CondN]=MLKNN_train(train_X,train_Y,Num,Smooth);
        [~,~,~,~,~,Outputs(:,i),Y_pred(:,i)]=MLKNN_test(train_X,train_Y,test_X,test_Y,Num,Prior,PriorN,Cond,CondN);
    end

end

