function [Accuracy, Sensitivity, Specificity, MCC,option] = libsvm_jk(data,group,svmparam)
row = size(data,1);
positive = find(group==1);
negative = find(group~=1);
Y_pred = zeros(row,1);
if nargin < 3
    [bestc,bestg,bestr]=libsvm_grid(data,group,5);
    option=['-c ' num2str(bestc) ' -g ' num2str(bestg)];
else
    option = svmparam;
end
for i = 1 : row
    trnlabel = true(row,1);
    trnlabel(i) = false;
    tstlabel = ~trnlabel;
    model = svmtrain(group(trnlabel),data(trnlabel,:),option);
    [Y_pred(i),acc,dev] = svmpredict(group(tstlabel),data(tstlabel,:),model);
end
TP = length(find(Y_pred(positive) == group(positive)));%true positive
TN = length(find(Y_pred(negative) == group(negative)));%true negative
FP = length(negative) - TN; %false positive
FN = length(positive) - TP; %false negative;
Accuracy = (TP+TN)/row;
Sensitivity = TP/(TP+FN);
Specificity = TN/(FP+TN);
MCC = (TP*TN - FP*FN)/sqrt((TP + FP)*(TN + FN)*(TP + FN)*(TN + FP));