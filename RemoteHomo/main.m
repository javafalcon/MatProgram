%  function Area = main()
% load 7329sequencesFamily.mat
% load 7329sequencesGrey21PSSM.mat
M=4205;
load 7329sequencesFamily_nr40.mat
load 7329sequencesGrey21PSSM_nr40.mat
psepssm=data;
javaaddpath('jforests.jar');

[heads,seqs] = fastaread('data\\7329sequences\\7329seqs_nr40.fasta');
% load KFold-5-Cross.mat
indices = crossvalind('kfold',M,5);
Auc = 0;
for i = 1 : 5
    testind = (indices == i);
    trainind = ~testind;
    trainX = psepssm(trainind,:);
    trainY = familyId(1,trainind);
    testX = psepssm(testind,:);
    testY = familyId(1,testind);
    trainId = seqId(1,trainind);
    testId = seqId(1,testind);
    
    %% write train data file
%     psiblast score and e-value
%     dbfasta = strcat('train',int2str(i),'.fasta');
%     if exist(dbfasta,'file')>0
%         delete(dbfasta);
%     end
%     fastawrite(dbfasta, heads(trainind),seqs(trainind));
%     dbname = strcat('train',int2str(i));
%     pairfile = strcat('train-train-pair',int2str(i));
% 
%     blastprotspair(dbfasta,dbname,dbfasta,pairfile);
%     [bitscore,eval] = pairVals(pairfile, trainId, trainId);
%     
%     %writing train data text file
%     distfeatures = zeros(4,size(trainX,1));
%     
%     trainFile = strcat('train-',int2str(i),'.txt');
%     if exist(trainFile,'file')>0
%         delete(trainFile);
%     end
%     fid_train = fopen(trainFile,'w');
%     for k = 1 : size(trainX,1)
%         fprintf('Training data: i=%d, k=%d\n',i,k);
%         
%         %grey incidence degree and cosin distance
%         giddist = GreyIncidenceDegree(trainX(k,:),trainX);
%         cosdist = CosinDistance(trainX,trainX(k,:));
%         distfeatures(1,:) = giddist/max(giddist);
%         distfeatures(2,:) = cosdist/max(cosdist);
%         
%         %normalize bitscore and eval
%         distfeatures(3,:) = bitscore(k,:)/max(bitscore(k,:));
%         distfeatures(4,:) = eval(k,:)/max(eval(k,:));
%         
%         for q = 1 : size(trainX,1)
%             if strcmp(trainY{q},trainY{k})
%                 fprintf(fid_train, '%d ', 1);
%             else
%                 fprintf(fid_train, '%d ', 0);
%             end
%             fprintf(fid_train, 'qid:%s %d:%f %d:%f %d:%f %d:%f\r\n', trainId{k}, 1, distfeatures(q), 2, distfeatures(q), 3, distfeatures(q), 4, distfeatures(q));
%         end
%     end
%     fclose(fid_train);
%      %converting data sets to binary format
%     cmd = 'del jforests*.txt';
%     system(cmd, '-echo');
%     [~,a,~] = fileparts(trainFile);
%     if exist(strcat(a,'.bin'),'file')>0
%         delete(strcat(a,'.bin'));
%     end
%     cmd = ['java -jar jforests.jar --cmd=generate-bin --ranking --folder . --file ' trainFile];
%     system(cmd,'-echo');
%     %training
%     if exist('ensemble.txt','file')>0
%         delete('ensemble.txt');
%     end
%     cmd = ['java  -Xms4000m -Xmx6000m -jar jforests.jar --cmd=train --ranking --config-file ranking.properties --train-file ' a '.bin --output-model ensemble.txt'];
%     system(cmd, '-echo');

    %% comput auc
    heads_test = heads(testind);
    seqs_test = seqs(testind);
    for k = 1 : size(testX,1)
        if exist('test.txt','file') > 0
            delete('test.txt');
        end
        fid_test = fopen('test.txt','w');
        fprintf('predicting: i=%d, k=%d\n',i,k);
        
%         write testX(k,:) test data file
%         1.psiblast score and e-value
        if exist('test.fasta','file') > 0
            delete('test.fasta');
        end
        fastawrite('test.fasta', heads_test(k),seqs_test(k));
        
        if exist('test-train-pair','file') > 0
            delete('test-train-pair');
        end
        cmd = ['psiblast -db ' dbname ' -query  test.fasta -out test-train-pair -outfmt 6'];
        system(cmd);
        [bitscore,eval] = pairVals('test-train-pair', testId{k}, trainId);
        bitscore = bitscore/max(bitscore);
        eval = eval/max(eval);
        
        %2.grey incidence degree and cosin distance
        giddist = GreyIncidenceDegree(testX(k,:),trainX);
        cosdist = CosinDistance(trainX,testX(k,:));
        giddist = giddist/max(giddist);
        cosdist = cosdist/max(cosdist);
        
        %3.write test data file
        label = zeros(size(trainX,1),1);
        for q = 1 : size(trainX,1)
            if strcmp(trainY{q}, testY{k})
                fprintf(fid_test, '%d ', 1);
                label(q) = 1;
            else
                fprintf(fid_test, '%d ', 0);
                label(q) = 0;
            end
            fprintf(fid_test, 'qid:%s %d:%f %d:%f %d:%f %d:%f\r\n', testId{k}, 1, giddist(q), 2, cosdist(q), 3, bitscore(q), 4, eval(q));
        end
        fclose(fid_test);
        
         %converting test data sets to binary format:"test.bin"
        if exist('test.bin','file')>0
            delete('test.bin');
        end
        cmd = 'del jforests*.txt';
        system(cmd, '-echo');
        cmd = ['java -jar jforests.jar --cmd=generate-bin --ranking --folder . --file test.txt' ];
        system(cmd,'-echo');
         %predicting
        if exist('prediction.txt','file') > 0
                delete('prediction.txt');
        end
        cmd = ['java -jar jforests.jar --cmd=predict --ranking --model-file ensemble.txt --tree-type RegressionTree --test-file  test.bin --output-file  prediction.txt'];
        system(cmd, '-echo');
        %comput auc
        fid_prediction = fopen('prediction.txt','r');
        preval = fscanf(fid_prediction,'%f');
        fclose(fid_prediction);

%         auc = AUC50(label,preval);
        auc = AUCK(label,preval,50);
        Auc = Auc + auc;
    end
    %%
end
Area = Auc/7329;
            
            
            
            