function [Accuracy, Sensitivity, Specificity, MCC,dev,option] = libsvm_kfold(data,group,kfold,svmparam)
row = size(data,1);
positive = find(group==1);
negative = find(group~=1);
Y_pred = zeros(row,1);
dev = zeros(row,1);
if nargin < 4
    [bestc,bestg,bestr]=libsvm_grid(data,group,5);
    option=['-c ' num2str(bestc) ' -g ' num2str(bestg)];
else
    option = svmparam;
end

indices = crossvalind('Kfold',1872,kfold);
for i = 1 : kfold
    trnlabel = true(row,1);
    trnlabel(indices==i) = false;
    tstlabel = ~trnlabel;
    model = svmtrain(group(trnlabel),data(trnlabel,:),option);
    [Y_pred(tstlabel),acc,dev(tstlabel)] = svmpredict(group(tstlabel),data(tstlabel,:),model);
end
TP = length(find(Y_pred(positive) == group(positive)));%true positive
TN = length(find(Y_pred(negative) == group(negative)));%true negative
FP = length(negative) - TN; %false positive
FN = length(positive) - TP; %false negative;
Accuracy = (TP+TN)/row;
Sensitivity = TP/(TP+FN);
Specificity = TN/(FP+TN);
MCC = (TP*TN - FP*FN)/sqrt((TP + FP)*(TN + FN)*(TP + FN)*(TN + FP));