function [ synX, synY ] = MLSMOTE( X, Y, varargin)
%   Input:
%       X       -X(i,:) corresponds to i-th instance.
%       Y       -Y(i,:) corresponds to the labels of i-th instance
%               Y(i,j)=1, if X(i,:) is belongs to j-th class; Y(i,j)=0, otherwise. 
%       [synX, synY] = MLSMOTE(X,Y,'NAME1',VALUE1,...,'NAMEN',VALUEN)
%       specifies optional argument name/value pairs:
%       Name            Value
%       'Amount'        A positive integer, specifying the amount of synthetic
%                       samples
%       'K'             A positive integer, K, specifying the number of nearest
%                       neighbors
%       'Loop'          A logical value indicating whether alogrithem ends
%                       after N synthesizing 
%       'LN'            A positive integer, LN, specifying the number of Loop
%       'Distance'      A string or a function handle specifying the
%                       distance function. The value can be one of the
%                       following:
%                       'euclidean'
%                           -Euclidean distance. This is default.
%                       'seuclidean'
%                           -Standardized Euclidean distance.
%                       'cityblock'
%                           -city Block distance.
%                       'cosin'
%                           -One minus the cosin of the included angle
%                           between observations.
%                       'minkowski'
%                           -Minkowski distance. The exponent is 2.
%                       'mahalanobis'
%                           -Mahalanobis distance.
%                       function
%                           -A distance function spcified using @ (for
%                           example @DISTFUN).
%                           A distance function must be of the
%                           form
% 
%                           function D2 = DISTFUN(ZI, ZJ),
% 
%                           taking as arguments a 1-by-N vector
%                           ZI containing a single row of X or
%                           Y, an M2-by-N matrix ZJ containing
%                           multiple rows of X or Y, and
%                           returning an M2-by-1 vector of
%                           distances D2, whose Jth element is
%                           the distance between the
%                           observations ZI and ZJ(J,:).
%
%   Output:
%       synX    -synthetic data
%       synY    -labels of synthetic data
%
%   Example:
%   [synX, synY] = MLSMOTE(X, Y, 'Amount', 3, 'K', 7);
%   [synX, synY] = MLSMOTE(X,Y,'Amount',3,'K',7,'Loop',true,'LN',50)
%   [synX, synY] = MLSMOTE(X,Y,'Distance',@GIDistance)
%   [synX, synY] = MLSMOTE(X,Y,'Distance','Euclidean')
    

    pnames = {'Amount', 'K', 'Loop', 'LN', 'Distance'};
    dflts = {3,7,false,10,'euclidean'};
    [Amount,K,loop,ln,dstf] = internal.stats.parseArgs( pnames, dflts, varargin{:});
    
    [numints, numattrs] = size(X);
    numclass = size(Y, 2);
    
    %Generating the synthetic samples
    synX = X;
    synY = Y;
    newIdx = numints + 1;
    
    if loop
        count = 1;
    end
    
    while (true)
        tempX = synX;
        tempY = synY;
        countclass = sum(synY,1);
        [classAmount, classI] = sort( countclass);
  
        mp = floor( classAmount( end) / classAmount( 1));
        if mp <= Amount %if dataset is balanced
            break;
        end
        
        c = classI(1);
        minX = synX( synY(:,c) == 1, :);%minority samples set
        minY = synY( synY(:,c) == 1, :);

        minclassAmount = size( minY, 1);

        for i = 1 : minclassAmount
            idx = true( minclassAmount, 1);
            idx(i) = false;
            XX = minX(idx,:);
            
            if K >= size(XX,1)
                K = size(XX,1);
            end
            %find the nearest neighbors of minX(i,:) from others samples in
            %minority set
%             [nnarry,~] = knnsearch( XX, minX(i,:), 'k', K, 'Distance', @GIDistance);
            [nnarry,~] = knnsearch( XX, minX(i,:), 'k', K, 'Distance', dstf);
            num = 1;
            while num <= Amount
                nn = randi(K,1);

                %generating an new instance.
                vec = zeros(1,numattrs);
                label = zeros( 1, numclass);

                for attr = 1 : numattrs
                    dif = XX( nnarry(nn), attr) - minX( i, attr);
                    gap = rand;
                    vec( attr) = minX( i, attr) + gap*dif;
                end

                label(c) = 1;

                %if minX(i,:) has two or more labels
                 if sum( minY( i, :)) > 1  
%                     R1 = log(mahal(vec, minX));%mahalanobis distance
                    [R1,I1] = sort(distance( vec, minX, dstf));%grey incidence degree 
                    for j = 1 : numclass
                        if ( j ~= c) && minY( i, j) == 1
                            %computing the distance between the new synthetic instance and j-th classes in which YY(i,j)=1
%                             R = log(mahal( vec, synX( synY(:, j)==1,:)));%mahalanobis distance
                            [R,I] = sort( distance( vec, synX( synY(:, j)==1, :), dstf));%grey incidence degree
                            if mean(R(I(1:K))) <= mean(R1(I1(1:K)))
                                label(j) = 1;
                            end
                        end
                    end
                 end

                 tempX( newIdx, :) = vec;
                 tempY( newIdx, :) = label;
                 newIdx = newIdx + 1;
                 num = num + 1;
            end %end while num < N
        end %end for
        synX = tempX;
        synY = tempY;
        
        if loop
        	count = count + 1;
            if count > ln
                break;
            end
        end
    end %end while( true)

end




