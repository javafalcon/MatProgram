testfiledir='data\testing\';
trainfiledir='data\training\';
test_N_seqs = cell(1,54);
test_P_seqs = cell(1,54);
train_N_seqs = cell(1,54);
train_P_seqs = cell(1,54);
for i=1:54
    testfile=[testfiledir 'Family-' num2str(i)];
    [heads, test_N_seqs{i}] = fastaread(strcat(testfile, '\N\N.txt'));
    [heads, test_P_seqs{i}] = fastaread(strcat(testfile,'\P\P.txt'));
    trainfile = [trainfiledir 'Family-' num2str(i)];
    [heads, train_N_seqs{i}] = fastaread(strcat(trainfile, '\N\N.txt'));
    [heads, train_P_seqs{i}] = fastaread(strcat(trainfile, '\P\P.txt'));
end
save remoteHomoData.mat train_N_seqs train_P_seqs test_N_seqs test_P_seqs;
    

