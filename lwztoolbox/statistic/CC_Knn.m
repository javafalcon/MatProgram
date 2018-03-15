function  Y_pred  = CC_Knn( TrainX, TrainY, TestX, K, distance)
%Classifier chains(CC) for multi-label classification
%  
%   Syntax
%
%   Y_pred=CC_Knn(TrainX, TrainY, TestX)
%
%   Input:
%
%       TrainX   -An NxM matrix, the i-th instance of training instance is
%                store in TrainX(i,:)
%       TrainY   -An NxQ matrix, if the i-th instance belongs to the j-th
%                class, then TrainY(i,j)=1, otherwise TrainY(i,j)=0;
%       TestX    -An N2xM matrix, the i-th instance of testing instance is
%                store in TestX(i,:)
%
%   Output:
%       Y_pred   -An N2xQ matrix, if the i-th testing instance belgongs to
%                the j-th class, then Y_pred(i,j)=1; otherwise Y_pred(i,j)=0;

    if nargin < 5
        distance = 'euclidean';
    end
    
    [N,Q] = size(TrainY);
    [N2,M] = size(TestX);
    
%training CC for training set TrainX and label set Trainy
    data = cell(Q,1);
    data{1} = TrainX;
    for j = 2 : Q
%partition jth binary training sets
        X = zeros(N,M+j-1);
        X(:,1:M+j-2) = data{j-1};
        X(:,M+j-1) = TrainY(:,j-1);
        data{j} = X;
    end
    
%test
    Y_pred = zeros(N2,Q);
    sample = TestX;
    for j = 1 : Q
        label = knnclassify(sample, data{j}, TrainY(:,j), K, distance);
%         mdl = fitcknn(data{j}, TrainY(:,j),'NumNeighbors', K, 'Distance', distance);
%         label = predict(mdl, sample);
%         label = greybiknnclassify(sample, data{j}, TrainY(:,j), K);
        Y_pred(:,j)  = label;
        sample = [sample label];
    end
        
        
end

