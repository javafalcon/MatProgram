function [Accuracy,Sensitivity,Specificity,MCC] = RF_fold(data,group,kfold,ntree,mtry)
[row,col] = size(data);
if nargin < 4
    ntree = 500;
    mtry = floor(sqrt(col));
end
positive = find(group==1);
negative = find(group~=1);
Y_pred = zeros(row,1);
indeces = crossvalind('Kfold',row,kfold);
for i = 1 : kfold
    tst = (indeces==i);
    trn = ~tst;
    model = classRF_train(data(trn,:),group(trn),ntree,mtry);
    Y_pred(tst) = classRF_predict(data(tst,:),model);
end
TP = length(find(Y_pred(positive) == group(positive)));%true positive
TN = length(find(Y_pred(negative) == group(negative)));%true negative
FP = length(negative) - TN; %false positive
FN = length(positive) - TP; %false negative;
Accuracy = (TP+TN)/row;
Sensitivity = TP/(TP+FN);
Specificity = TN/(FP+TN);
MCC = (TP*TN - FP*FN)/sqrt((TP + FP)*(TN + FN)*(TP + FN)*(TN + FP));