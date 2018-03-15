function [posProb, negProb]= MLKnn2_train(XT,YT,K)
%XT: training dataset, N by M
%YT: training dataset labels, N by Q

[N,Q] = size(YT);

YC = sum(YT,1);
%%compute distance
dist_matrix = diag(realmax*ones(1,N));
for i = 1 : N-1
    vector1 = XT(i,:);
    for j = i+1 : N
        vector2 = XT(j,:);
        dist_matrix(i,j) = sqrt(sum((vector1-vector2).^2));
        dist_matrix(j,i) = dist_matrix(i,j);
    end
end
%% Neighbors(i,1) store the K neighbors of the i-th training instance
Neighbors = zeros(N,K);
for i = 1 : N
    [~,index] = sort(dist_matrix(i,:));
    Neighbors(i,:) = index(1:K);
end
%% Compute posterior probability
posC = zeros(1,Q);
negC = zeros(1,Q);
for i = 1 : N
    I = sum( YT( Neighbors(i,:),:),1);
    for q = 1 : Q
        if I(q) > K/2
            if YT(i,q) == 1 
                posC(q) = posC(q) + 1;
            else 
                negC(q) = negC(q) + 1;
            end
        end
    end
end
posProb = posC./YC;
negProb = negC./(N-YC);

end
