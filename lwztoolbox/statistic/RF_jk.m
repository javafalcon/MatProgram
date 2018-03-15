function [Accuracy, Sensitivity, Specificity, MCC] = RF_jk(data,group,mtree,nnode)
[row,col] = size(data);
if nargin < 3
    mtree = 500;
    nnode = floor(sqrt(col));
end

positive = find(group==1);
negative = find(group~=1);
Y_pred = zeros(row,1);
for i = 1 : row
    i
    trnlabel = true(row,1);
    trnlabel(i) = false;
    tstlabel = ~trnlabel;
    model = classRF_train(data(trnlabel,:),group(trnlabel),mtree,nnode);
    Y_pred(i) = classRF_predict(data(tstlabel,:),model);
end
TP = length(find(Y_pred(positive) == group(positive)));%true positive
TN = length(find(Y_pred(negative) == group(negative)));%true negative
FP = length(negative) - TN; %false positive
FN = length(positive) - TP; %false negative;
Accuracy = (TP+TN)/row;
Sensitivity = TP/(TP+FN);
Specificity = TN/(FP+TN);
MCC = (TP*TN - FP*FN)/sqrt((TP + FP)*(TN + FN)*(TP + FN)*(TN + FP));