clear;
clc;
% load 7329sequencesFamily.mat
% load 7329sequencesGrey21PSSM.mat
load 7329sequencesGrey21PSSM_nr40.mat
% pssm=data;
D=data;
load 7329sequences_pssm_GLCMFeature_nr40.mat
glcm=data;

Row = 4205;
% Col = 84;
% 
% D=zeros(Row,Col);
% for i = 1 : Row
%     D(i,:)=[pssm(i,:) glcm(i,:)];
% end
% load 7329sequences_pssm_momentsFeature_nr40.mat data
load 7329sequencesFamily_nr40.mat
load 3187sequences_blastscore.mat 
% load 7329sequence_nr40_gm21.mat data
% psepssm=data(:,1:20);
[heads,seqs] = fastaread('data\\7329sequences\\7329seqs_nr40.fasta');
heads=heads(I);
seqs=seqs(I);

familyId=familyId(I);
seqId=seqId(I);
N = length(seqId);
Y = zeros(N,1);
Auc50 = 0;
Auc1 = 0;
psepssm = D(I,:);

for i = 1 : N
    i
    ind = true(N,1);
    ind(i) = false;
    trainX = psepssm(ind,:);
    trainY = familyId(ind);
    
    testX = psepssm(i,:);
    testY = familyId{i};
    
    label_Y = strcmp(trainY,testY);
    r = GreyIncidenceDegree(testX,trainX);
    b = mapminmax(bitscore(i,:),0,1);
%     r=distance(testX,trainX,'cosin');
    
    %blast score
    trainId = seqId(ind);
    testId = seqId{i};

    
    Auc1 = Auc1 + AUCK(label_Y,r+b,1,'descend');
    Auc50 = Auc50 + AUCK(label_Y,r+b,50,'descend');
end
Auc50 = Auc50/N;
Auc1 = Auc1/N;
