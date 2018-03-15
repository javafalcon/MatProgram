function [Y_pred, Output] = MLKNNRL(trainX, trainY, testX, k, distance, s, beta, threshold)
%input:
%   trainX      -A N-by-M matrix, trainX(i,:) express i-th instance
%   trainY      -A N-by-Q matrix, the labels of i-th instance is stored in
%                trainY(i,:). if i-th instance is labeled j-th class,
%                trainY(i,j) = 1; otherwise trainY(i,j) = 0
%   testX       -A N2-by-M matrix
%   k           -the number of nearest neighbors
%   distance    -a string of distance
%   s           -a smooth coefficient
%
%output:
%   Y_pred      -the predicted labels of testX

[N, Q] = size(trainY);

%Computing prior probability of each class
prip = (s+sum(trainY,1))/(2*s+N);
% nprip = 1 - prip;

%Training. 
%Computing conditional probability which there are t instances labeled j-th class
%in an instance k nearest neighbors when it is labeled i-th class. And the 
%conditional probability is stored in conp{i}(j,t);
conp = cell(Q,1);
nconp = cell(Q,1);
nnp = zeros(Q,k+1);
for i = 1 : Q
    conp{i} = zeros(Q, k+1);
    nconp{i} = zeros(Q, k+1);
end

for i = 1 : N
    ind = true(N,1);
    ind(i) = false;
    target = trainY(ind,:);
    %Computing k nearest neighbors of i-th instance
    [idx,~] = knnsearch( trainX(ind,:), trainX(i,:), 'distance', distance, 'K', k);
    g = sum(target(idx,:),1);
    
    for q = 1 : Q
        if g(q) == 0
            g(q) = k+1;
        end
        nnp(q,g(q)) = nnp(q,g(q)) + 1;
    end
    
    for q = 1 : Q
        if trainY(i,q) == 1
            for t = 1 : Q
                conp{q}(t, g(t))= conp{q}(t, g(t)) + 1;
            end
        else
            for t = 1 : Q
                nconp{q}(t, g(t)) = nconp{q}(t, g(t)) + 1;
            end
        end
    end
end

for t = 1 : Q
    for q = 1 : Q
        conp{t}(q,:) = ( s + conp{t}(q,:)) / ( s * (k + 1) + sum(conp{t}(q,:)));
        nconp{t}(q,:) = ( s + nconp{t}(q,:)) / ( s * (k + 1) + sum(nconp{t}(q,:)));
    end
end

nnp = (s + nnp)/(s * (k + 1) + sum( sum( nnp,1)));

%Testing
N2 = size(testX,1);
Output = zeros(N2,Q);
Y_pred = zeros(N2,Q);
for i = 1 : N2
    %Computing k nearest neighbors of testX(i,:)
    [idx,~] = knnsearch( trainX, testX, 'distance', distance, 'K', k);
    E = sum(trainY(idx,:),1);
    for q = 1 : Q
        if E(q) >= k*beta(q)
            Y_pred(i,q) = 1;
            Output(i,q) = 1;
        else if E(q) <= k*(1-beta(q))
                Y_pred(i,q) = 0;
                Output(i,q) = 0;
            else
                out1 = 1;
                out2 = 1;
                for t = 1 : Q
                    c = E(t);
                    if c == 0
                        c = k+1;
                    end
                    out1 = out1 * conp{q}(t, c)*prip(q);
                    out2 = out2 * nnp(t,c);
                end
                Output(i,q) = out1/(s + out2);
                if Output(i,q) >= threshold(q) 
                    Y_pred(i,q) = 1;
                end
            end
        end
    end
    
end


                
    

