function Auc50=main_3187seqs(x)

load 3187sequences_Grey21PSSM.mat
load 3187sequences_GLCMFeatures.mat
load 3187sequences_blastscore.mat 
load 3187sequencesFamily.mat
load 3187sequences_fuzadaFeatures.mat
fzd=fzd(:,1:6)';
fzd=mapminmax(fzd,0,1)';
Row = 3187;
% Col = 82;

% D=zeros(Row,Col);
% for i = 1 : Row
%     D(i,:)=[psepssm(i,:) glcm(i,[1 3])];
% end

Auc50 = 0;
% Auc1 = 0;

for i = 1 : Row
    ind = true(Row,1);
    ind(i) = false;
    trainX_psepssm = psepssm(ind,:);
    trainX_glcm = glcm(ind,[1 3]);
    trainX_fzd = fzd(ind,:);
    trainY = familyId(ind);
    
    testX_psepssm = psepssm(i,:);
    testX_glcm = glcm(i,[1 3]);
    testX_fzd = fzd(i,:);
    testY = familyId{i};
    
    label_Y = strcmp(trainY,testY);
%     r = GreyIncidenceDegree([testX_psepssm testX_glcm],[trainX_psepssm trainX_glcm]);
    r = GreyIncidenceDegree(testX_psepssm,trainX_psepssm);
    d = GreyIncidenceDegree(testX_glcm, trainX_glcm);    
    b = mapminmax(bitscore(i,:),0,1);
%     f = distance(testX_fzd,trainX_fzd);
    f = GreyIncidenceDegree(testX_fzd,trainX_fzd);
%    f = mapminmax(f',0,1);
    dis=x(1)*r + x(2)*b + x(3)*d + x(4)*(1-f);
%     dis=x(1)*r + x(2)*b;
%     Auc1 = Auc1 + AUCK(label_Y,dis,1,'descend');
    Auc50 = Auc50 + AUCK(label_Y,dis,50,'descend');
end
Auc50 = Auc50/Row;
% Auc1 = Auc1/Row;
