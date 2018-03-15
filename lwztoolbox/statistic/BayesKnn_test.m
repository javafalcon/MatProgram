function [ Pred_Y, Pred_R ] = BayesKnn_test( Test_X, Train_X, Train_Y, postprob, K, priprob)
%BayesKnn_test tests a two-labels k-nearest neighbor classifier
%   

    num_training = size(Train_X,1);
    
    if nargin == 6
        posPr = priprob(1);
        negPr = priprob(2);
    end
    if nargin == 5
        %compute prior probability
        posPr = sum(Train_Y)/num_training;
        negPr = 1 - posPr;
    end
        
    %compute prediction output
    num_test = size(Test_X,1);
    Pred_Y = zeros(num_test,1);
    Pred_R = zeros(num_test,1);
    for i = 1 : num_test
        d = dist(Train_X, Test_X(i,:)');
        [~,I] = sort(d);
        m = sum(Train_Y(I(1:K)));
        if m == 0
            m = K+1;
        end
        
        a = posPr*postprob{1}(m);
        b = negPr*postprob{2}(m);
        if a>b
            Pred_Y(i) = 1;
        else
            Pred_Y(i) = 0;
        end
        Pred_R(i) = a/(a+b);
    end
end

