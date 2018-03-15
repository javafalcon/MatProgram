function Y_hat = ALKNN_jk( trnX, trnY, varargin )
% Accumulation-label K-nearest neighbor classifier
% Chou, K.C., Wu, Z.C., and Xiao, X. iLoc-Hum: using the accumulation-label
% scale to predict subcellular locations of human proteins with both single
% and multiple sites. Mol. Biosyst. 2012, 8(2): 629-641.
% Input parameters:
%   trnX    A N by M matrix, the i-th row express the i-th training 
%           instance.
%   trnY    A N by Q matrix, the i-th row express the labels of i-th
%           instance. If i-th belongs to the j-th class, trnY(i,j)=1; 
%           otherwise trn(i,j)=0.
%   distfun A string or funciton handle specifying the distance function
%            which can be the following value:
%           'euclidean':
%               Euclidean distance. This is default.
%           'seuclidean':
%               Standardized Euclidean distance.
%           'cityblock':
%               city Block distance.
%           'cosin'
%               One minus the cosin of the included angle between 
%               observations.            
%           'minkowski'
%               Minkowski distance. The exponent is 2.
%           'mahalanobis'
%               Mahalanobis distance.
%
%           function
%               A distance function spcified using @ (for example @DISTFUN).
%               A distance function must be of the form
% 
%                function D2 = DISTFUN(ZI, ZJ),
% 
%                taking as arguments a 1-by-N vector ZI containing a
%                single row of X or Y, an M2-by-N matrix ZJ containing
%                multiple rows of X or Y, and returning an M2-by-1 vector 
%                of distances D2, whose Jth element is the distance between 
%                the observations ZI and ZJ(J,:).
%
% Output:
% Y_hat     A N by Q matrix, the predicted result for tstX
%
    pnames = {'K', 'distfun'};
    dflts = {1,'euclidean'};
    [k,distfun] = internal.stats.parseArgs( pnames, dflts, varargin{:});
    
    [N,Q] = size(trnY);
    Y_hat = zeros(N,Q);
    
    %% predicting
    for i = 1 : N
        indx = true(N,1);
        indx(i) = false;
        tstX = trnX(i,:);
        Y_hat(i,:) = ALKNN(trnX(indx,:), trnY(indx,:), tstX, 'K', k, 'distfun', distfun);
    end
    
    %% measure the performance
    Pre_Labels = (Y_hat' -0.5)*2;
    Y = (trnY' - 0.5)*2;
    HammingLoss = Hamming_loss(Pre_Labels,Y);
    SubsetAccuracy = SubsetAcc(Pre_Labels,Y);
    Precision = MLPrecision(trnY, Y_hat);
    Recall = MLRecall(trnY, Y_hat);
        
    %% output prediction performance
    fprintf('\\neighbors=%d\n',k);
    fprintf('HammingLoss=%6.4f\n', HammingLoss);
    fprintf('SubsetAccuracy=%6.4f\n', SubsetAccuracy);
    fprintf('Precision=%6.4f\n', Precision);
    fprintf('Recall=%6.4f\n', Recall);
    
end

