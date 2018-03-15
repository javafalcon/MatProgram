clear;
clc;
load 7329sequencesFamily_nr40.mat
load 7329sequencesGrey21PSSM_nr40.mat
familyId=familyId(I);
seqId=seqId(I);
M = 3187;
[trainX,testX]=crossvalind('HoldOut',M,0.2);
trX = data(trainX,:);
trY = familyId(1,trainX);
tsX = data(testX,:);
tsY = familyId(1,testX);
    
[trainR,trainC] = size(trX);
[testR,testC] = size(tsX);
    
 %构建训练数据
trainData=zeros(trainR*trainR, 2*trainC);
trainTarget = zeros(trainR*trainR,1);
j=1;
for q = 1 : trainR
    for k = 1 : trainR
        trainData(j,:)=[trX(q,:) trX(k,:)];
        if strcmp(trY{q}, trY{k})
            trainTarget(j) = 1;
        else
            trainTarget(j) = 0;
        end
        j = j + 1;
    end
end

net=newff(trainData',trainTarget,[30,1],{'tansig','purelin'},'traincgb');
net.trainParam.lr=0.05;
net.trainParam.epochs=500;
net.trainParam.goal=1e-5;
[net,tr]=train(net,trainData,trainTarget);

%构建测试数据
testData = zeros(testR*trainR,testC+trainC);
testTarget = zeros(testR*trainR,1);
j=1;
for q = 1 : testR
    for k = 1 : trainR
        testData(j,:)=[tsX(q,:) trX(k,:)];
        if strcmp(testY{q}, trainY{k})
            testTarget(j) = 1;
        else
            testTarget(j) = 0;
        end
        j = j + 1;
    end
end

Y_hat=sim(net,testData);

Auc1=0;
Auc50=0;
for j = 1 : testR
    label_Y = testTarget((j-1)*trainR+1:j*trainR,1);
    prev = Y_hat((j-1)*trainR+1:j*trainR);
    Auc1 = Auc1 + AUCK(label_Y,prev,1,'descend');
    Auc50 = Auc50 + AUCK(label_Y,prev,50,'descend');
end

