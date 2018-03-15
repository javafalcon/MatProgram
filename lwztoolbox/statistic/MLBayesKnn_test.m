function Y_pred = MLBayesKnn_test( x, XT, YT, postProb, postProbN, K, priProb, priProbN)
%MLBayesKnn_test tests a multi-labels k-nearest neighbor classifier

    [num_training,num_labels] = size(YT);
    %% Compute distance
    dist_matrix=zeros(num_training,1);
    for i=1:num_training
        vector1=XT(i,:);
        dist_matrix(i)=sqrt(sum((vector1-x).^2));
    end
    %% Neighbors stores the K neighbors of the testing instance
    [tempM,index]=sort(dist_matrix);
    Neighbors=index(1:K);
    temp = sum(YT(Neighbors,:));
    for i = 1 : length(temp)
        if temp(i) == 0
            temp(i) = K+1;
        end
    end
    
    %% Comput predict output
    y = zeros(num_labels,1);
    yn = zeros(num_labels,1);
    for t = 1 : num_labels
        for j = 1 : num_labels
            y(t) = y(t) + postProb{t}(j,temp(j))*priProb(t)/(postProb{t}(j,temp(j))*priProb(t)+postProbN{t}(j,temp(j))*priProbN(t));
            yn(t) = yn(t) + postProbN{t}(j,temp(j))*priProbN(t)/(postProb{t}(j,temp(j))*priProb(t)+postProbN{t}(j,temp(j))*priProbN(t));
        end
    end
    
    %% output
    Y_pred = zeros(num_labels,1);
    for t = 1 : num_labels
        if y(t) > yn(t)
            Y_pred(t) = 1;
        else
            Y_pred(t) = 0;
        end
    end

end

