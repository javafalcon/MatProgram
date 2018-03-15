function Y_hat = ALKNN( trnX, trnY, tstX, varargin )
% Accumulation-label K-nearest neighbor classifier
% Chou, K.C., Wu, Z.C., and Xiao, X. iLoc-Hum: using the accumulation-label
% scale to predict subcellular locations of human proteins with both single
% and multiple sites. Mol. Biosyst. 2012, 8(2): 629-641.
% Input parameters:
%   trnX    A N1 by M matrix, the i-th row express the i-th training 
%           instance.
%   trnY    A N1 by Q matrix, the i-th row express the labels of i-th
%           instance. If i-th belongs to the j-th class, trnY(i,j)=1; 
%           otherwise trn(i,j)=0.
%   tstX    A N2 by M matrix, the i-th row express the i-th testing
%           instance.
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
% Y_hat     A N2 by Q matrix, the predicted result for tstX
%
    pnames = {'K', 'distfun'};
    dflts = {1,'euclidean'};
    [k,distfun] = internal.stats.parseArgs( pnames, dflts, varargin{:});
    
    Q = size(trnY,2);
    N2 = size(tstX,1);
    
    Y_hat = zeros(N2,Q);
    
    %% predicting
    for i = 1 : N2
        % find the k-nearest neigbor in trnX for each instance in tstX
        [nnarray,~] = knnsearch(trnX, tstX(i,:), 'K', k, 'Distance', distfun);
        % compute the numbers of labels of the nearest neigbor
        nl = sum( trnY( nnarray(1),:),2);
        % compute the score for each class and rank
        P = sum( trnY( nnarray, :), 1);
        P = P/sum(P);
        [~,I] = sort(P,'descend');
        % predict the label of tstX(i,:)
        Y_hat(i,I(1:nl)) = 1;
    end
end

