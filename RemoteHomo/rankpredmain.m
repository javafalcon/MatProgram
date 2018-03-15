clear
clc
load 7329sequencesFamily.mat
load 7329sequencesGrey21PSSM.mat
javaaddpath('jforests.jar');

[heads,seqs] = fastaread('data\\7329sequences\\7329seqs.fasta');
load KFold-5-Cross.mat
Auc = 0;
for i = 1 : 5
    testind = (indices == i);
    trainind = ~testind;
%     trainX = psepssm(trainind,:);
%     trainY = familyId(1,trainind);
%     testX = psepssm(testind,:);
%     testY = familyId(1,testind);
%     trainId = seqId(1,trainind);
%     testId = seqId(1,testind);
    
    %% training
     %converting data sets to binary format
%     trainFile = strcat('train-',int2str(i),'.txt');
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
    ensemble = strcat('ensemble-',int2str(i),'.txt');
    %% testing
    num_test = sum(testind);
    num_train = sum(trainind);
 
    testFile = strcat('test-',int2str(i),'.txt');
    fid_test = fopen(testFile,'r');
   
    for j = 1 : num_test
        label = zeros(num_train,1);
        % write predicting text
        if exist('test.txt','file') > 0
            delete('test.txt');
        end
        fid_pred = fopen('test.txt','w');
        for k = 1 : num_train
            tline = fgetl(fid_test);
            label(k) = str2double(tline(1));
            fwrite(fid_pred, tline);
        end
        fclose(fid_pred);
        
        %converting test data sets to binary format:"test.bin"
        if exist('test.bin','file')>0
            delete('test.bin');
        end
        cmd = 'del jforests*.txt';
        system(cmd, '-echo');
        cmd = 'java -jar jforests.jar --cmd=generate-bin --ranking --folder . --file test.txt' ;
        system(cmd,'-echo');
        
         %predicting
        if exist('prediction.txt','file') > 0
                delete('prediction.txt');
        end
%         cmd = 'java -jar jforests.jar --cmd=predict --ranking --model-file ensemble.txt --tree-type RegressionTree --test-file  test.bin --output-file  prediction.txt';
        cmd = ['java -jar jforests.jar --cmd=predict --ranking --model-file  ', ensemble, '  --tree-type RegressionTree --test-file  test.bin --output-file  prediction.txt'];
        system(cmd, '-echo');
        
        %comput auc
        fid_prediction = fopen('prediction.txt','r');
        preval = fscanf(fid_prediction,'%f');
        fclose(fid_prediction);

        auc = AUCK(label,preval,50);
        Auc = Auc + auc;
    end
end
    %%

Area = Auc/7329;
            
            
            
            