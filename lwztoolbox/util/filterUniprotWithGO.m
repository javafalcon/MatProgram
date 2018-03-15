function filterUniprotWithGO(uniProtFile, outUniProtFile, goProtRefFile)
% fileterUniprotWithGO
%         find out all sequences which have been annotated gene ontology (GO) term
% Input:
%   uniProtFile     -the name of file which store uniprot as fasta file.
%   outUniProtFile  -the file store those proteins who have go annotated as
%                    fasta file.
%   goProtRefFile   -A mat file sotre the GO ids for each protein.
conn = conndb();
[head,seq]=fastaread(uniProtFile);
sql=['SELECT distinct term.acc '...
     'FROM gene_product '...
     'INNER JOIN dbxref ON (gene_product.dbxref_id=dbxref.id) '...
     'INNER JOIN species ON (gene_product.species_id=species.id) '...
     'INNER JOIN association ON (gene_product.id=association.gene_product_id) '...
     'INNER JOIN evidence ON (association.id=evidence.association_id) '...
     'INNER JOIN term ON (association.term_id=term.id) '...
     'WHERE dbxref.xref_key = '''];
 
go = {};
heads={};
seqs={};
k = 1;
for i = 1 : length(head)
    C = strsplit(head{i}, '|');
    pid = C{2};
    sqlquery = [sql pid '''' 'order by term.acc asc'];
    curs = exec(conn,sqlquery);
    curs = fetch(curs);
    A = curs.Data;
    close(curs);
    if strcmp('No Data',A) ~= 1
        go{k} = A;
        heads{k} = pid;
        seqs{k} = seq{k};
        k = k + 1;
    end
end

close(conn);

fastawrite(outUniProtFile,heads,seqs);
save(goProtRefFile,'go','heads');
    