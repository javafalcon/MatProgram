clear
clc

 pssm_P = blastpssm('AllFamilySeqs.fasta', 'swissprot');
 save AllFamilySeqsPSSM pssm_P