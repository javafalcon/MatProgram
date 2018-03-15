function [ threshold, wc ] = AdaboostKnn_train( data,groups,T, K )
%Adaboosting by knn classifier for binary imbalance datastet
%Input:
%   data: N by M matrix, N samples with M features
%   groups: N columm vector, 1 - positive samples; -1 - negative samples
%   T: the number of iterating step
%   K: the maximum value of neighbours
%Out put:
%   threshold: threshold for each classifier
%   wc: the weight of each classifier
N = length(groups);
Weight = zeros(N,1);
posNum = sum(groups==1);
negNum = sum(groups==-1);
%initial weight
Weight(groups==1) = 1/(2*posNum);
Weight(groups==-1) = 1/(2*negNum);
t = 1;
e = 1;
threshold= [];
wc = [];
mdl = fitcknn(data,groups,'NumNeighbors',K);
[l,score]=resubPredict(mdl);
   
flag = true;
%training classifier
while (t < T && e > 1.0e-6 && flag)
    flag = false;
    for thres = 1 : -0.005 : 0
        h = ones(N,1);
        indx = score(:,1)>thres;
        h(indx) = -1;
        e = sum(Weight.*(h~=groups));
        disp(strcat('error is: ', num2str(e)));
        if (0.5-e)> 1.0e-6
            a = 0.5*log((1-e)/e);
            d = exp(-a*(groups.*h));
            z = sum(Weight.*d);
            Weight = (Weight.*d)/z;
            threshold =[ threshold; thres];
            wc = [wc;a];
            flag = true;
            break;
        end
    end
    t = t + 1;
end
end

