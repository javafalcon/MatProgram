clear;
clc;

fid = fopen('Supp-S1.txt');
tline = fgetl(fid);
i = 1;
while ischar(tline)
    if startsWith(tline,'>')
        heads{i} = tline;
        tline = fgetl(fid);
        seqs{i} = strtrim(tline);
        i = i+1;
    end
    tline = fgetl(fid);
end
fastawrite('AllFamilySeqs.fasta',heads,seqs);