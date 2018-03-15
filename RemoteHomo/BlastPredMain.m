   
clear;
clc;

load 7329sequencesFamily.mat
% familyId=familyId(I);
% seqId=seqId(I);
N = length(seqId);
Y = zeros(N,1);
Auc50 = 0;
Auc1 = 0;

[heads,seqs] = fastaread('data\\7329sequences\\7329seqs.fasta');
% heads=heads(I);
% seqs=seqs(I);
bitscore = zeros(N,N-1);
for i = 1 : N
    i
    trainind = true(N,1);
    trainind(i) = false;
    trainId = seqId(trainind);
    trainY = familyId(trainind);
    
    testId = seqId{i};
    testY = familyId{i};
    
    label_Y = strcmp(trainY,testY);
    
    %psiblast score and e-value
    dbfasta = 'train.fasta';
    if exist(dbfasta,'file')>0
        delete(dbfasta);
    end
    fastawrite(dbfasta, trainId,seqs(trainind));
    
    inputfile = 'test.fasta';
    if exist(inputfile, 'file')>0
        delete(inputfile);
    end
    fastawrite(inputfile,testId,seqs{i});
    
    dbname = 'train';
    pairfile = 'pairfile';

    blastprotspair(dbfasta,dbname,inputfile,pairfile);
    [bitscore(i,:),eval] = pairVals(pairfile, testId, trainId);
    
    
    Auc1 = Auc1 + AUCK(label_Y,bitscore(i,:),1,'descend');
    Auc50 = Auc50 + AUCK(label_Y,bitscore(i,:),50,'descend');
end
Auc50 = Auc50/N;
Auc1 = Auc1/N;
save 7329sequences_blastscore.mat bitscore