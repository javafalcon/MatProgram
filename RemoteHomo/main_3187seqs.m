clear;
clc;
load 3187sequences_Grey21PSSM.mat
load 3187sequences_GLCMFeatures.mat
load 3187sequences_blastscore.mat 
load 3187sequencesFamily.mat
load 3187sequences_hmmscore.mat
%load 3187sequences_fuzadaFeatures.mat
x=[0.25 0.05 0.3 0.4];
% Result:
% x=[0 0 0 1]: Auc1=0.6981 Auc50=0.7052
% x=[0.25 0.2 0.35 0.2]: Auc1=0.7358 Auc50=0.7970
% x=[0.25 0.1 0.35 0.3]: Auc1=0.7411 Auc50=0.8002
% x=[0.25 0.05 0.4 0.3]: Auc1=0.7436 Auc50=0.8022
% x=[0.25 0.05 0.3 0.4]: Auc1=0.7427 Auc50=0.8029
Row = 3187;


Auc50 = 0;
Auc1 = 0;

for i = 1 : Row
    i
    ind = true(Row,1);
    ind(i) = false;
    trainX_psepssm = psepssm(ind,:);
    trainX_glcm = glcm(ind,[1 3]);
    trainY = familyId(ind);
    
    testX_psepssm = psepssm(i,:);
    testX_glcm = glcm(i,[1 3]);
    testY = familyId{i};
    
    label_Y = strcmp(trainY,testY);
%     r = GreyIncidenceDegree([testX_psepssm testX_glcm],[trainX_psepssm trainX_glcm]);
    r = GreyIncidenceDegree(testX_psepssm,trainX_psepssm);
    d = GreyIncidenceDegree(testX_glcm, trainX_glcm);    
    b = mapminmax(bitscore(i,:),0,1);
    h = mapminmax(hmmscore(i,ind),0,1);
    dis=x(1)*r + x(2)*b + x(3)*d + x(4)*h;
%     dis=x(1)*r + x(2)*b;
    Auc1 = Auc1 + AUCK(label_Y,dis,1,'descend');
    Auc50 = Auc50 + AUCK(label_Y,dis,50,'descend');
end
Auc50 = Auc50/Row;
Auc1 = Auc1/Row;
