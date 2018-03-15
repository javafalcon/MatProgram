function Y_pred = MLKNS(trainX, trainY, k, testX, beta, s, distance, threshold)
%rough set theory
%Input:
%   trainX:     -training data, a N-by-M matrix, i-th instance is expressed
%                by trainX(i,:);
%   trainY:     -target, a N-by-Q matrix, the labels of i-th instance is stored in trainY(i,:) 

[~, Q] = size(trainY);
%Training. Computing the conditional probability
condp = zeros(Q,Q);
for i = 1 : Q
    for j = 1 : Q
%         indx1 = (( ( trainY(:,i) == 1) + ( trainY(:,j) == 1)) == 2);
        indx2 = ( trainY(:,j) == 1);
        indx1 = (trainY(indx2,i)==1);
        condp(i,j) = sum(indx1)/( sum(indx2) + s);
    end
end

%Testing. 
Y_pred = zeros( size( testX,1), Q);
for i = 1 : size(testX, 1)
    %Computing the neighborhood &(x) of testing instance x
    [idx,~] = knnsearch( trainX, testX(i,:), 'distance', distance, 'K', k);
    pri = zeros( Q, 1);
    
    %Computing the prior probability
    t = sum( trainY( idx, :), 1);
    c = sum( t);
    for j = 1 : Q
        pri(j) = t(j)/c;
    end
    
    %Computing the probability of the testing instance x
    for k = 1 : Q
        if t(k) >= k*beta
            Y_pred( i, k) = 1;
        else if t(k) <= k*(1-beta)
                Y_pred( i, k) = 0;
            else
                p = 0;
                for m = 1 : Q
                    p = p + pri(m)*condp(k,m);
                end
                if p >= threshold
                    Y_pred( i, k) = 1;
                else
                    Y_pred( i, k) = 0;
                end
            end
        end
    end
end
        
    

