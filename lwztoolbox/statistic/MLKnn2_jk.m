function Y_pred = MLKnn2_jk( XT,YT,K )
%XT: training dataset, N by M
%YT: training dataset labels, N by Q

[N,Q] = size(YT);
YC = sum(YT,1);
priProb = YC/N;

Y_pred = zeros(N,Q);
R_pred = zeros(N,Q);
for i = 7 : N
    disp(strcat('Testing ',  int2str(i), '-th instance'));
    x = XT(i,:);
    indx = true(N,1);
    indx(i) = false;
    TrainX = XT(indx,:);
    TrainY = YT(indx,:);
    [posProb, negProb] = MLKnn2_train(TrainX,TrainY,K);
    [Y_pred(i,:),R_pred(i,:)] = MLKnn2_test(x,TrainX,TrainY,posProb,negProb,K,priProb);
end
confusionmat(YT, Y_pred)

