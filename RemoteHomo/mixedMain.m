clear;
clc;
load 7329sequencesFamily.mat
load 7329sequencesGrey21PSSM.mat

[heads,seqs] = fastaread('data\\7329sequences\\7329seqs.fasta');
Auc50 = 0;
Auc1 = 0;
for i = 1 : 7329
    i
    ind = true(7329,1);
    ind(i) = false;
    trainX = psepssm(ind,:);
    trainY = familyId(ind);
    
    testX = psepssm(i,:);
    testY = familyId{i};
    
    label_Y = strcmp(trainY,testY);
    trainId = seqId(1,ind);
    testId = seqId{i};
    %% grey incidence degree
     r = GreyIncidenceDegree(testX,trainX);
     r = r/max(r);
     
     %% psi-blast bitscore
     dbfasta = 'train.fasta';
    if exist('train.fasta','file') > 0
        delete('train.fasta');
    end
    fastawrite(dbfasta, heads(ind),seqs(ind));
    
    dbname = 'train';
    cmd =[ 'makeblastdb -in ' dbfasta ' -dbtype prot -parse_seqids -out ' dbname ];
    system(cmd, '-echo');%generate db
    
    cmd =[ 'move ' dbname '.* "E:\\Program Files\\NCBI\\blast-2.5.0+\\db\\"'];
    system(cmd, '-echo');
    cmd = ['move ' '"E:\\Program Files\\NCBI\\blast-2.5.0+\\db\\' dbname '.fasta  .'];
    system(cmd, '-echo');
    heads_test = heads{i};
    seqs_test = seqs{i};
    if exist('test.fasta','file') > 0
        delete('test.fasta');
    end
    fastawrite('test.fasta', heads_test,seqs_test);
    
    if exist('pair','file') > 0
        delete('pair');
    end
    cmd = ['psiblast -db ' dbname ' -query  test.fasta -out pair -outfmt 6'];
    system(cmd);
    [bitscore,eval] = pairVals('pair', testId, trainId);
    bitscore = bitscore/max(bitscore);
    eval = 1-eval/max(eval);
    
    %%
    preval = (r + bitscore + eval)/3;
    
    Auc1 = Auc1 + AUCK(label_Y, preval, 1);
    Auc50 = Auc50 + AUCK(label_Y, preval, 50);
end
Auc1 = Auc1/7329;
Auc50 = Auc50/7329;