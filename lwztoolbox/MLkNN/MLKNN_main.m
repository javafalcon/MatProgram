function Y_hat = MLKNN_main( data, group, varargin  )
%   Input:
%       data     -A N by M matrix, data(i,:) expresses the i-th sample.
%       group    -A N by Q matrix, where group(i,j)=1 if data(i,:) is
%                 belonged to j-th class otherwise group(i,j) = 0.
%   Y_pred = MLKNN_main(data, group, 'NAME1',VALUE1,...,'NAMEN',VALUEN) 
%   specifies optional argument name/value pairs:
%   Name        Value
%   'K'          A positive integer, K, specifying the number of nearest
%                neighbors of MLKNN algorithmic.
%   'SMOTE'      A logical value indicating whether MLSMOTE will be called
%                to synthetic new samples.
%   'Amount'     A positive integer, Amount, specifying the amount of
%                MLSMOTE function.
%   'Snn'        A positive integer, Snn, specifying the number of nearest
%                neighbors which will be used in MLSMOTE.
%   'Distance'   A string or function handle specifying the distance
%                function which can be seen in the MLSMOTE function.
%   Example:
%
%       Y_pred =
%       MLKNN_main(data,group,'K',11,'SMOTE',true,'Amount',3,'Snn',7);
%
    %% default value
    
    
    %% parse parameter
    pnames = {'k','SMOTE','Amount','Snn','Loop','LN','Distance'};
    dflts = {1,false,3,7,false,10,'euclidean'};
    [k,smote,amount,snn,loop,ln,dstf] = internal.stats.parseArgs( pnames, dflts, varargin{:});
    
    
    %%
    [N,Q] = size(group);
    Y_pred = zeros(Q,N);

    if (smote)
        for i = 1 : N
            fprintf('\ni=: %d',i);
            ind = true(N,1);
            ind(i) = false;
            
            %partition training data and testing data
            train_X = data(ind,:);
            train_Y = group(ind,:);
            test_X = data(i,:);
            test_Y = group(i,:);
            
            %MLSMOTE generate new dataset
            [synX, synY] = MLSMOTE( train_X, train_Y, 'Amount', amount, 'K', snn, 'Loop', loop, 'LN', ln, 'Distance', dstf);
             synY = (synY' - 0.5)*2;
             
            %Computing Prior and PriorN
            Smooth = 1;
            Prior = zeros(Q,1);
            PriorN = zeros(Q,1);
            for j = 1:Q
                temp_Ci=sum(train_Y(:,j)==ones(N-1,1));
                Prior(j,1)=(Smooth+temp_Ci)/(Smooth*2+(N-1));
                PriorN(j,1)=1-Prior(j,1);
            end
            
            %Calling MLKNN alogrithem to train and predict 
            [~,~,Cond,CondN]=MLKNN_train(synX,synY,k,1);
            [~,~,~,~,~,~,Y_pred(:,i)]=MLKNN_test(synX,synY,test_X,test_Y',k,Prior,PriorN,Cond,CondN);
        end
    else
        for i = 1 : N
            fprintf('\ni=: %d',i);
            ind = true(N,1);
            ind(i) = false;
            
            %partition training data and testing data
            train_X = data(ind,:);%training data
            train_Y = ( group(ind,:)' - 0.5) * 2;
            test_X = data(i,:);%testing data
            test_Y = group(i,:)';
            
            %Calling MLKNN alogrithem to train and predict 
            [Prior,PriorN,Cond,CondN]=MLKNN_train(train_X,train_Y,k,1);
            [~,~,~,~,~,~,Y_pred(:,i)]=MLKNN_test(train_X,train_Y,test_X,test_Y,k,Prior,PriorN,Cond,CondN);
        end
    end
    
    %% Compute prediction performance
    Y_hat = (Y_pred'+1)/2;
    train_target = (group'-0.5)*2;
    HammingLoss=Hamming_loss(Y_pred,train_target);
    SubsetAccuracy=SubsetAcc(Y_pred,train_target);
    Precision = MLPrecision( group, Y_hat );
    Recall = MLRecall(group, Y_hat);
    
    %% output prediction performance
    fprintf('\nneighbors=%d\n',k);
    fprintf('HammingLoss=%6.4f\n', HammingLoss);
    fprintf('SubsetAccuracy=%6.4f\n', SubsetAccuracy);
    fprintf('Precision=%6.4f\n', Precision);
    fprintf('Recall=%6.4f\n', Recall);
    predictStatisInfo(Y_hat, group);
end
