function [Auc50,Auc1]=main_7329seqs(x)

load 7329sequencesGrey21PSSM.mat
% load 7329sequences_pssm_GLCMFeature.mat
load 7329sequences_pssm_zernikeMoment.mat
load 7329sequences_blastscore.mat 
load 7329sequencesFamily.mat


Row = 7329;
% Col = 82;

% D=zeros(Row,Col);
% for i = 1 : Row
%     D(i,:)=[psepssm(i,:) glcm(i,[1 3])];
% end

Auc50 = 0;
Auc1 = 0;

for i = 1 : Row
    i
    ind = true(Row,1);
    ind(i) = false;
    trainX_psepssm = psepssm(ind,:);
    trainX_glcm = X(ind,:);
    trainY = familyId(ind);
    
    testX_psepssm = psepssm(i,:);
    testX_glcm = X(i,:);
    testY = familyId{i};
    
    label_Y = strcmp(trainY,testY);
    r = GreyIncidenceDegree(testX_psepssm,trainX_psepssm);
    d = GreyIncidenceDegree(testX_glcm, trainX_glcm);    
    b = mapminmax(bitscore(i,:),0,1);
    
    dis=x(1)*r + x(2)*b + x(3)*d;
    Auc1 = Auc1 + AUCK(label_Y,dis,1,'descend');
    Auc50 = Auc50 + AUCK(label_Y,dis,50,'descend');
end
Auc50 = Auc50/Row;
Auc1 = Auc1/Row;
