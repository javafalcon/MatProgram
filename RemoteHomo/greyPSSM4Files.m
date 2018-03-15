    clear;
    clc;
%[heads,seqs]=fastaread('AllFamilySeqs.fasta');
    [heads,seqs]=fastaread('data\\7329sequences\\7329seqs.fasta');
    row = length(heads);
    for k = 1 : row
        disp(k);
              
        M = zeros(length(seqs{k}),40);
        
        %fid_out = fopen( strcat('data\\AllFamilySeqsPSSM\\pssmresult_',num2str(k)), 'r');
        fid_out = fopen(strcat('data\\7329sequences\\pssmresult_',num2str(k-1)),'r');
        if fid_out == -1
            sequence = seqs{k};
			disp([heads{k} ': can not be hitted in ' fastaFile ]);
            for i = 1 : length(sequence)
                t = strfind( aaletters, sequence(i));
                M(i,1:20) = blosumMatrix(t,1:20);
            end
            p{k} = M;
        else
            for i = 1 : 4
                tline=fgetl(fid_out);
            end
            i = 1;
            while ischar(tline) && ~isempty(tline)
                A = sscanf(tline,'%d %s %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d');
                M(i,:) = A(3:42)';
                i=i+1;
                tline=fgetl(fid_out);
            end
            p{k}=M;
            fclose(fid_out);
        end
    end
