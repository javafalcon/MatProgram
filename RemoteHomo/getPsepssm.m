clear;
clc;
testfiledir='data\testing\';
trainfiledir='data\training\';
data_train = cell(1,54);
data_test = cell(1,54);
target_train = cell(1,54);
target_test = cell(1,54);
for i = 1 : 54
    trainfile=[trainfiledir 'Family-' num2str(i)];
    disp(strcat('PSSM of ', trainfile));
    pssm_P = blastpssm(strcat(trainfile, '_P.fasta'), 'swissprot');
    disp(strcat('PSSM of ', trainfile));
    pssm_N = blastpssm(strcat(trainfile, '_N.fasta'), 'swissprot');
    M1 = greyPsePssm(pssm_P, 2);
    M2 = greyPsePssm(pssm_N, 2);
    L1 = size(M1,1);
    L2 = siez(M2,1);
    data_train{i} = [M1; M2];
    target_train{i} = [ones(L1,1); -ones(L2,1)];
end
save train_greyPsePssm.mat data_train target_train
 
for i = 1 : 54
    testfile=[testfiledir 'Family-' num2str(i)];
    disp(strcat('PSSM of ', trainfile));
    pssm_P = blastpssm(strcat(testfile, '_N.fasta'), 'swissprot');
    disp(strcat('PSSM of ', trainfile));
    pssm_N = blastpssm(strcat(testfile, '_P.fasta'), 'swissprot');
    M1 = greyPsePssm(pssm_P, 2);
    M2 = greyPsePssm(pssm_N, 2);
    L1 = size(M1,1);
    L2 = siez(M2,1);
    data_test{i} = [M1; M2];
    target_test{i} = [ones(L1,1); -ones(L2,1)];
end
save test_greyPsePssm.mat data_test target_test