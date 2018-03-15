clear;
clc;
load 7329sequencesFamily_nr40.mat
load 7329sequence_nr40_momentsFeatures.mat

M = size(data,1);
Y = zeros(M,1);
Auc50 = 0;
Auc1 = 0;
for i = 1 : M
    i
    ind = true(M,1);
    ind(i) = false;
    trainX = data(ind,:);
    trainY = familyId(ind);
    
    testX = data(i,:);
    testY = familyId{i};
    
    label_Y = strcmp(trainY,testY);
%     r = GreyIncidenceDegree(testX,trainX);
    r = distance(testX,trainX);
     
    Auc1 = Auc1 + AUCK(label_Y,r,1);
    Auc50 = Auc50 + AUCK(label_Y,r,50);
end
Auc50 = Auc50/M;
Auc1 = Auc1/M;