clear;
clc;
testfiledir='data\testing\';
trainfiledir='data\training\';
data_train = cell(1,54);
data_test = cell(1,54);
target_train = cell(1,54);
target_test = cell(1,54);
AAindexCode = 'Hydrophobicity';
isStd = 1;
type = 2;
for i = 1 : 54
    trainfile=[trainfiledir 'Family-' num2str(i)];
    M1 = getGMPseByAAindex(strcat(trainfile, '_P.fasta'), AAindexCode, isStd, type);
    M2 = getGMPseByAAindex(strcat(trainfile, '_N.fasta'), AAindexCode, isStd, type);
    L1 = size(M1,1);
    L2 = size(M2,1);
    data_train{i} = [M1; M2];
    target_train{i} = [ones(L1,1); -ones(L2,1)];
end
save train_greyPseAAC.mat data_train target_train
 
for i = 1 : 54
    testfile=[testfiledir 'Family-' num2str(i)];
    M1 = getGMPseByAAindex(strcat(testfile,'_P.fasta'),AAindexCode,isStd,type);
    M2 = getGMPseByAAindex(strcat(testfile,'_N.fasta'),AAindexCode,isStd,type);
    L1 = size(M1,1);
    L2 = size(M2,1);
    data_test{i} = [M1; M2];
    target_test{i} = [ones(L1,1); -ones(L2,1)];
end
save test_greyPseAAC.mat data_test target_test