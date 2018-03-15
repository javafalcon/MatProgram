function Y_pred = AdaboostKnn_jk( train, groups, T, K )
%AdaboostKnn_predict: predict instances in train by jackknife.
%Input:
%   train: training data, N by M matrix
%   groups: N column vector
%   neighbours and wc: the model trained by AdaboostKnn_train
N = size(train,1);
[neighbours,wc]=AdaboostKnn_train(train,groups,T,K);

H = length(wc);
Y_pred = zeros(N,1);
for i = 1 : N
    disp(strcat('testing No.', int2str(i), ': .........'));
    f = 0;
    indx = true(N,1);
    indx(i) = false;
    mdl = fitcknn(train(indx,:),groups(indx),'NumNeighbors',K);
    [l,score] = predict(mdl,train(i,:));
    for j = 1 : H
        h = 1;
        if score(:,1) > neighbours(j)
            h = -1;
        end
        f = f + h*wc(j);
    end
    if f >= 0
        Y_pred(i) = 1;
    else
        Y_pred(i) = -1;
    end
end
end

