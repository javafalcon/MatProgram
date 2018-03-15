clear
clc
load 7329sequencesFamily_nr40.mat
[heads,seqs]=fastaread('data\\7329sequences\\7329seqs_nr40.fasta');
Len = length(seqs);
data = zeros(Len,4);
for i = 1 : Len
    disp(i);
    D = CA(seqs{i},28,84);
%     data(i,:) = MomentsFeature(D,10);
%     data(i,:) = data(i,:)/norm(data(i,:));
    [ASM_E,CON_E,ENT_E,IDM_E] = GLCM_FEATURE(D);
    data(i,:)=[ASM_E CON_E ENT_E IDM_E];
end
[data,~]=mapminmax(data,0,1);
save 7329sequence_nr40_GLCMFeatures.mat data
