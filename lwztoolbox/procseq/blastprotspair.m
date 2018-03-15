function blastprotspair(dbfasta, dbname, inputfile, pairfile)
    cmd =[ 'makeblastdb -in ' dbfasta ' -dbtype prot -parse_seqids -out ' dbname ];
    system(cmd);
    cmd =[ 'move ' dbname '.* \"e:/program files/ncbi/blast-2.5.0+/db/\"'];
    system(cmd);
    cmd = ['psiblast -db ' dbname ' -query ' inputfile ' -out ' pairfile ' -outfmt 6'];
    system(cmd);
    
    