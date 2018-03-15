function Y_hat = RMLKNN_independent(trndata, trngroups, tstdata, tstgroups, varargin)
    %
    pnames = {'K', 'distfun'};
    dflts = {10,'euclidean'};
    [k,distfun] = internal.stats.parseArgs( pnames, dflts, varargin{:});
    
    [N1, Q] = size( trngroups);
    
    % Cauculate prior probability of i-th class
    PriProb = sum( trngroups, 1) / N1;
    nonPriProb = 1 - PriProb;
    
    %% train
    %
    % Cauculate prior probability of which there are m samples labeled j-th
    % class in the k nearest neighbors of a sample labeled i-th class.
    PriProbRL = cell( 1, Q);
    nonPriProbRL = cell( 1, Q);
    for m = 1 : Q
       PriProbRL{m} = zeros( Q, k+1); % k+1 column express 0 neighbor
       nonPriProbRL{m} = zeros( Q, k+1);
    end
    
    for n = 1 : N1
       % find the k-nearest neigbors in training dataset for n-th training
       % sample.
        [nnarray,~] = knnsearch( trndata, trndata( n, :), 'K', k+1, 'Distance', distfun);
        
        A = sum( trngroups( nnarray( 2 : end), :), 1);
        
        for m = 1 : Q
            % In k-nearest neighbors of a sample with i-th label
            if trngroups( n, m) == 1
                for j = 1 : Q
                    if A(j) > 0
                        % the number of samples with j-th label is A(j)
                        PriProbRL{m}( j, A(j)) = PriProbRL{m}( j, A(j)) + 1;
                    else
                        % if the number is 0
                        PriProbRL{m}( j, k+1) = PriProbRL{m}( j, k+1) + 1;
                    end % if A(j) > 0
                end% for j
            else % In k-nearest neighbors of a sample without i-th label
                for j = 1 : Q
                    if A(j) > 0
                        nonPriProbRL{m}( j, A(j)) =  nonPriProbRL{m}( j, A(j)) + 1;
                    else
                        nonPriProbRL{m}( j, k+1) = nonPriProbRL{m}( j, k+1) + 1;
                    end
                end
                
            end % if
        end % for m
    end % for n
    
    for m = 1 : Q
       PriProbRL{m} = PriProbRL{m} ./ repmat( sum( PriProbRL{m},2), 1, k+1);
%        nonPriProbRL{m} = nonPriProbRL{m} ./ N1;
    end
    %% End training
    
    %% test
    N2 = size( tstgroups, 1);
    Y_hat = zeros( N2, Q);
    for n = 1 : N2
        [nnarray,~] = knnsearch( trndata, tstdata( n, :), 'K', k, 'Distance', distfun);
        A = sum( trngroups(nnarray,:), 1);
        for m = 1 : Q
            p = 1; np = 1;
            
            for j = 1 : Q
                if A(j) > 0
                    p = p * PriProbRL{m}( j, A(j));
%                     np = np * nonPriProbRL{m}( j, A(j));
                else
                    p = p * PriProbRL{m}( j, k+1);
%                     np = np * nonPriProbRL{m}( j, k+1);
                end
                p = p * PriProb( m); 
%                 np = np * nonPriProb( m);
            end
            
            Y_hat( n, m) = p;
        end
    end
    %% End testing
    
    %% Measure
%     MLMeasure(tstgroups, Y_hat);
end