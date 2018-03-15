function prots = getHomologousProts( protseq, varargin )
%find all gene ontologies for the homologous proteins of protseq

    pnames = {'blastdbname','evalue','threshold'};
    dflts = {'swissprot', 1, 11};
    [dbname,evalue,threshold] = internal.stats.parseArgs(pnames,dflts,varargin{:});

    blastcmd = ['blastp -db ' dbname ...
                ' -query hominputfile.fasta -out homoutputfile.txt -evalue '...
                num2str(evalue)...
                ' -threshold '...
                num2str(threshold)...
                ' -outfmt "10 sallacc" -seg "yes"'];
            
%     if exist('inputfile.fasta','file') > 0
%             delete('inputfile.fasta');
%     end   
    if exist('outputfile.txt','file') > 0
            delete('outputfile.txt');
    end
    
    fid_in = fopen('inputfile.fasta','w');
    fprintf(fid_in, protseq);
    fclose(fid_in);
        
    system(blastcmd);
    
    prots = {};
    k = 1;
    fid_out = fopen('outputfile.txt','r');
    if fid_out < 0
        disp([protseq '\nhasn''t Homologous Proteins\n']);
        return;
    end
    
    tline=fgetl(fid_out);
    while ischar(tline) && ~isempty(tline)
        prots{k} = tline;
        k = k + 1;
        tline=fgetl(fid_out);
    end
    fclose(fid_out);
end

