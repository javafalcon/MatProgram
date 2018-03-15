function blastpssmfile(fastaFile,db,pssmFile)

[heads,seqs]=fastaread(fastaFile);

row = length(heads);

cmd = ['psiblast -db ' db ' -query input.fasta -num_iterations 3 -evalue 0.001 -out_ascii_pssm pssmTemp'];
fid_pssm = fopen(pssmFile,'a');

for k = 1 : row
    k
    fprintf(fid_pssm,'>%d\n',k);
    fid_in = fopen('input.fasta','w');
    fprintf(fid_in,seqs{k});
    fclose(fid_in);
    
    system(cmd);
    
    fid_out = fopen('pssmTemp','r');
    for i = 1 : 4
        tline=fgetl(fid_out);
    end

    while ischar(tline) && ~isempty(tline)

        fprintf(fid_pssm,'%s\n',tline);

        tline=fgetl(fid_out);
    end
   
    fclose(fid_out);
end
fclose(fid_pssm);