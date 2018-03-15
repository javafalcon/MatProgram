function getPSSMFile(fastaFile,db,dir)
% alignmented in db.
% get pssm and save it in dir
cmd = ['psiblast -db ' db ' -query input.fasta -num_iterations 3 -threshold 0.01 -word_size 2 -evalue 10 -out_ascii_pssm '];
[heads,seqs]=fastaread(fastaFile);

if ~ischar(heads)
    row = length(heads);
     for k = 1 : 1
         k=6471;
        disp(k);
        fid_in = fopen('input.fasta','w');
        fprintf(fid_in,seqs{k});
        fclose(fid_in);
        
        pssmfile = [dir '\pssmresult_' num2str(k-1)];
        
        execmd = [cmd pssmfile];
        %perform blast program
        [~,~]=system(execmd);
     end
else %just only one sequence
    fid_in = fopen('input.fasta','w');
    fprintf(fid_in,seqs);
    fclose(fid_in);
    
    pssmfile = [dir '\pssmresult'];
        
    execmd = [cmd pssmfile];
    
    %perform blast program
    system(execmd);
end