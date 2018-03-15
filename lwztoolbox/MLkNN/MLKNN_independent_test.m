function Y_hat = MLKNN_independent_test( trnX, trnY, tstX, tstY, varargin )
%MLKNN indepent test
% Input:
%   trnX       -A N1 by M matrix, trndata(i,:) expresses the i-th
%                    training sample.
%   trnY       -A N1 by Q matrix, where trngroups(i,j)=1 if i-th traing
%                    sample is belonged to j-th class, otherwise
%                    trngroups(i,j)=0.
%   tstX       -A N2 by M matrix, tstdata(i,:) expresses the i-th
%                    testing sample.
%   tstY       -A N2 by Q matrix.
%
%   Y_hat = MLKNN_indepent_test(trndata,trngroups,tstdata,tstgroups,...
%           'NAME1',VALUE1,...,'NAMEN',VAVLUEN);
%   specifies optional argument NAME/VALUE pairs:
%   Name          Value
%   'K'           A positive integer, K, specifying the number of
%                   nearestn neighbors of MLKNN algorithmic.
%   'SMOTE'       A logical value indicating whether MLSMOTE will be called
%                   to synthetic new sample.
%   'Amount'      A positive integer, Amount, specifying the amount of
%                   MLSMOTE function.
%   'Snn'         A positive integer, Snn, specifying the number of nearest
%                   neighbors which will be used in MLSMOTE.
%   'Loop'        A logical value indicating whether the numbers of loop is
%                   limited. 
%   'LN'          A positive integer, LN, specifying the number of loop
%                   if Loop is specified true.
%   'Distance'    A string or funciton handle specifying the distance
%                   function which can be seen in the MLSMOTE function.
%
%   Example:
%
%       Y_hat = MLKNN_indepent_test(trnd,trng,tstd,tstg,'K',11,'SMOTE',...
%                                   true,'Amount',3,'Snn',7);

    %% default value
    pnames = {'Smooth','K','SMOTE','Amount','Snn','Loop','LN','Distance'};
    dflts = {1,1,false,3,7,false,10,'euclidean'};
    [Smooth,k,smote,amount,snn,loop,ln,dstf] = internal.stats.parseArgs(pnames,dflts,varargin{:});
    
    %%
    [N1,Q] = size(trnY);
        
    %Computing Prior and PriorN
    Prior = zeros(Q,1);
    PriorN = zeros(Q,1);
    for j = 1 : Q
        temp_Ci = sum(trnY(:,j)==ones(N1,1));
        Prior(j,1) = (Smooth + temp_Ci)/(Smooth*2 + (N1-1));
        PriorN(j,1) = 1 - Prior(j,1);
    end
        
    if (smote)
        %MLSMOTE generate new dataset
        [synX, synY] = MLSMOTE( trnX,trnY,'Amount',amount,'K', snn, 'Loop', loop, 'LN', ln, 'Distance', dstf);
        synY = (synY' - 0.5)*2;
    else
        synX = trnX;
        synY = trnY;
    end
        
    %% Calling MLKNN alogrithem to train 
    [~,~,Cond,CondN] = MLKNN_train(synX, synY, k, Smooth);
        
    %% Calling MLKNN_test alogrithem to predict
    [~,~,~,~,~,Outputs,Pre_Labels]=MLKNN_test(synX,synY,tstX,(tstY'-0.5)*2,k,Prior,PriorN,Cond,CondN);
    
    %% measure the performance
    Y_hat = (Pre_Labels' + 1)/2;
    Y = (tstY' - 0.5)*2;
    HammingLoss = Hamming_loss(Pre_Labels,Y);
    SubsetAccuracy = SubsetAcc(Pre_Labels,Y);
    Precision = MLPrecision(tstY, Y_hat);
    Recall = MLRecall(tstY, Y_hat);
    OneError = One_error(Outputs,Y);
    Coverage = coverage(Outputs,Y);
    Average_Precision = Average_precision(Outputs,Y);
    
    %% output prediction performance
    fprintf('\\neighbors=%d\n',k);
    fprintf('HammingLoss=%6.4f\n', HammingLoss);
    fprintf('SubsetAccuracy=%6.4f\n', SubsetAccuracy);
    fprintf('Precision=%6.4f\n', Precision);
    fprintf('Recall=%6.4f\n', Recall);
    fprintf('OneError=%6.4f\n', OneError);
    fprintf('Coverage=%6.4f\n', Coverage);
    fprintf('Average_Precision=%6.4f\n', Average_Precision);
    
    
end

