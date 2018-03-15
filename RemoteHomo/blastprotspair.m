%dbfasta: database file with fasta format
%dbname: database name
%inputfile: query sequences file
%pairfile: sequence-sequence blast output
function blastprotspair(dbfasta, dbname, inputfile, pairfile)
    cmd =[ 'makeblastdb -in ' dbfasta ' -dbtype prot -parse_seqids -out ' dbname ];
    system(cmd, '-echo');
    cmd =[ 'move ' dbname '.* "E:\\Program Files\\NCBI\\blast-2.5.0+\\db\\"'];
    system(cmd, '-echo');
    cmd = ['move ' '"E:\\Program Files\\NCBI\\blast-2.5.0+\\db\\' dbname '.fasta  .'];
    system(cmd, '-echo');
    cmd = ['psiblast -db ' dbname ' -query ' inputfile ' -out ' pairfile ' -outfmt 6'];
    system(cmd, '-echo')
    
    