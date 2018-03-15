function [ postprob] = BayesKnn_train(Train_X, Train_Y, K, S)
%BayesKnn_train trains a two-labels k-nearest neighbor classifier by Bayes

%Train_X: training dataset matrix with N by M, 
%         the ith instance of training instance is stored in Train_X(i,:)
%Train_Y: training dataset's labels matrix with N by one. If i-th instance
%         is labeled positive, Train_Y(i)=1; else Train_Y(i)=0;
%K: the numbers of k-nearest neighbor
%S: the smoothing parameter
%priPb: prior probability with two elements: [posPr; negPr} 

    N = size(Train_X,1);
    if nargin < 4
        S = 0;
    end
    %% Compute distance
    dist_matrix=diag(realmax*ones(1,N));
    for i=1:N-1
        vector1=Train_X(i,:);
        for j=i+1:N            
            vector2=Train_X(j,:);
            dist_matrix(i,j)=sqrt(sum((vector1-vector2).^2));
            dist_matrix(j,i)=dist_matrix(i,j);
        end
    end
    %% Neighbors{i,1} stores the K neighbors of the ith training instance
    Neighbors=zeros(N,K); 
    for i=1:N
        [~,index]=sort(dist_matrix(i,:));
        Neighbors(i,:)=index(1:K);
    end
    %% Compute posterior probability
    posC = zeros(K+1,1);
    negC = zeros(K+1,1);
    for i = 1 : N
        m = sum(Train_Y(Neighbors(i,:)));
        if Train_Y(i) == 1
            if m == 0
                posC(K+1) = posC(K+1) + 1;
            else
                posC(m) = posC(m) + 1;
            end
        else
            if m == 0
                negC(K+1) = negC(K+1) + 1;
            else
                negC(m) = negC(m) + 1;
            end
        end
    end
    postprob{1} = (S+posC)/(S*(K+1)+sum(posC));
    postprob{2} = (S+negC)/(S*(K+1)+sum(negC));
    
end

