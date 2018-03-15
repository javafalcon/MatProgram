function [postProb, postProbN] = MLBayesKnn_train(XT, YT, K, S )
%MLBayesKnn_train trains a multi-labels k-nearest neighbor classifier by Bayes
%XT: training dataset matrix with N rows 
%    the ith instance of training instance is stored in Train_X(i,:)
%YT: training dataset's labels matrix with N by M
%K:  the numbers of k-nearest neighbor
%S:  the smoothing parameter
%postProb: the posterior probability, N by N by K+1

    [N,M] = size(YT);
    if nargin == 3
        S = 0;
    end
    %% Compute distance
    dist_matrix=diag(realmax*ones(1,N));
    for i=1:N-1
        vector1=XT(i,:);
        for j=i+1:N            
            vector2=XT(j,:);
            dist_matrix(i,j)=sqrt(sum((vector1-vector2).^2));
            dist_matrix(j,i)=dist_matrix(i,j);
        end
    end
    %% Neighbors{i,1} stores the K neighbors of the ith training instance
    Neighbors=cell(N,1); 
    for i=1:N
        [tempM,index]=sort(dist_matrix(i,:));
        Neighbors{i,1}=index(1:K);
    end
    %%
    C1 = zeros(M,M,K+1);
    C0 = zeros(M,M,K+1);
    for i = 1 : N
        temp = sum(YT(Neighbors{i,1},:));
        for j = 1 : M
            if YT(i,j) == 1
                for t = 1 : M
                    if temp(t) > 0
                        %temp(t) instances have tth label,when ith training
                        %instance has jth lable
                        C1(j,t,temp(t)) = C1(j,t,temp(t))+1;
                    else
                        %0 instance has tth label, when ith training
                        %instance has jth label
                        C1(j,t,K+1) = C1(j,t,K+1) + 1;
                    end
                end
            else 
                for t = 1 : M
                    if temp(t) > 0
                        %temp(t) instances have tth label,when ith training
                        %instance has jth lable
                        C0(j,t,temp(t)) = C0(j,t,temp(t))+1;
                    else
                        %0 instance has tth label, when ith training
                        %instance has jth label
                        C0(j,t,K+1) = C0(j,t,K+1) + 1;
                    end
                end
            end%end else
        end%end j loop
    end%end i loop
    %%
    postProb = cell(M,1);
    postProbN = cell(M,1);
    for i = 1 : M
        postProb{i} = zeros(M, K+1);
        postProbN{i} = zeros(M, K+1);
        for j = 1 : M
            for t = 1 : K+1
                postProb{i}(j,t) = (S+C1(i,j,t))/(S*(K+1)+sum(sum(C1(i,:,:))));
                postProbN{i}(j,t) = (S+C0(i,j,t))/(S*(K+1)+sum(sum(C0(i,:,:))));
            end
        end
    end

end%end function

