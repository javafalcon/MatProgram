function [Accuracy,Sensitivity,Specificity,MCC]=RF_independent(data,group,model)
row = size(data,1);
positive = find(group==1);
negative = find(group~=1);
Y_pred = classRF_predict(data,model);
TP = length(find(Y_pred(positive) == group(positive)));%true positive
TN = length(find(Y_pred(negative) == group(negative)));%true negative
FP = length(negative) - TN; %false positive
FN = length(positive) - TP; %false negative;
Accuracy = (TP+TN)/row;
Sensitivity = TP/(TP+FN);
Specificity = TN/(FP+TN);
MCC = (TP*TN - FP*FN)/sqrt((TP + FP)*(TN + FN)*(TP + FN)*(TN + FP));

