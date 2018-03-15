%  function Area = main()
% load 7329sequencesFamily.mat
% load 7329sequencesGrey21PSSM.mat
M=3187;
load 7329sequencesFamily_nr40.mat
load 7329sequencesGrey21PSSM_nr40.mat
familyId=familyId(I);
seqId=seqId(I);
psepssm=data(I,[5 1 10 8 19 12 11 39 77]);
% load 7329sequence_nr40_momentsFeatures.mat
% psepssm=data(I,[5 1 10 8 19 12 11 39 77]);

% [heads,seqs] = fastaread('data\\7329sequences\\7329seqs_nr40.fasta');

indices = crossvalind('kfold',M,5);
Auc1 = 0;
Auc50 = 0;

for i = 1 : 5
    testind = (indices == i);
    trainind = ~testind;
    trainX = psepssm(trainind,:);
    trainY = familyId(1,trainind);
    testX = psepssm(testind,:);
    testY = familyId(1,testind);
    
    [trainR,trainC] = size(trainX);
    [testR,testC] = size(testX);
    
    %构建训练数据
    trainData=zeros(trainR*trainR, 2*trainC);
    trainTarget = zeros(trainR*trainR,1);
    j=1;
    for q = 1 : trainR
        for k = 1 : trainR
            trainData(j,:)=[trainX(q,:) trainX(k,:)];
            if strcmp(trainY{q}, trainY{k})
                trainTarget(j) = 1;
            else
                trainTarget(j) = 0;
            end
            j = j + 1;
        end
    end
    %用随机森林训练回归模型
%     model = classRF_train(trainData,trainTarget);
    [W, Xi, D] = mlr_train(trainData', trainTarget, 1e-2, 'AUC');
    %构建测试数据
    testData = zeros(testR*trainR,testC+trainC);
    testTarget = zeros(testR*trainR,1);
    j=1;
    for q = 1 : testR
        for k = 1 : trainR
            testData(j,:)=[testX(q,:) train(k,:)];
            if strcmp(testY{q}, trainY{k})
                testTarget(j) = 1;
            else
                testTarget(j) = 0;
            end
            j = j + 1;
        end
    end
    %用随机森林回归模型测试
    Y_hat = classRF_predict(testData,model);
    
    for j = 1 : testR
        label_Y = testTarget((j-1)*trainR+1:j*trainR,1);
        prev = Y_hat((j-1)*trainR+1:j*trainR);
        Auc1 = Auc1 + AUCK(label_Y,prev,1,'descend');
        Auc50 = Auc50 + AUCK(label_Y,prev,50,'descend');
    end
end
Auc50 = Auc50/              N;
Auc1 = Auc1/N;
        


            
            
            
            