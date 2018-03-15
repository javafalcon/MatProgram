clear
clc
load 7329sequencesFamily_nr40.mat
file = 'data\\7329sequences\\7329seqs_nr40.fasta';
AAindexCode = 'Hydrophobicity';
isStd = 0;
type = 2;

data = getGMPseByAAindex(file, AAindexCode, isStd, type);

save 7329sequence_nr40_gm21.mat data
