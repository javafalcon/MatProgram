function [ Y_pred, R_pred ] = MLKnn2_test( x,XT,YT,posProb,negProb,K,priProb )
%x: test instance, row vector with M colums
%XT: training instance, N by M
%YT: training instance labels, N by Q
%posProb: posterior probability. An instance has more than half neighbors 
%         labeled as q-th class when it is labeled as q-th class
%negProb: posterior probability. An instance has more than half neighbors 
%         labeled as q-th class when it is not labeled as q-th class.
%K: the number of nearest neighbor
%priPorb: prior probability
[N,Q] = size(YT);
Y_pred = zeros(1,Q);
R_pred = zeros(1,Q);

%%Compute distance
dist_matrix = realmax*ones(1,N);
for i = 1 : N
    dist_matrix(i) = sqrt(sum((x-XT(i,:)).^2));
end
[~,index] = sort(dist_matrix);
%%Find K neighbors
Neighbors = index(1:K);
NC = sum(YT(Neighbors,:),1);

%%Compute prediction output
for q = 1 : Q
    if NC(q) > K/2
        a = posProb(q)*priProb(q);
        b = negProb(q)*(1-priProb(q));
        if a > b
            Y_pred(q) = 1;
            R_pred(q) = a/(a+b);
        end
    else
        a = (1-posProb(q))*priProb(q);
        b = (1-negProb(q))*(1-priProb(q));
        if a > b
            Y_pred(q) = 1;
            R_pred(q) = a/(a+b);
        end
    end
end

end %end Function

