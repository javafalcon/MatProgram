[head,seq]=fastaread('data\\7329sequences\\7329sequence_nr40.fasta');
len = length(head);
seqId = cell(1,len);
familyId = cell(1,len);
for i = 1 : len
    [seqId{i},remain] = strtok(head{i});
    [familyId{i},remain] = strtok(remain);
end
save 7329sequencesFamily_nr40.mat seqId familyId
