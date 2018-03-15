function go = getGO4Prot( conn,swissprotid )
%

    sqlformat='SELECT distinct term.acc FROM gene_product INNER JOIN dbxref ON (gene_product.dbxref_id=dbxref.id) INNER JOIN species ON (gene_product.species_id=species.id) INNER JOIN association ON (gene_product.id=association.gene_product_id) INNER JOIN evidence ON (association.id=evidence.association_id) INNER JOIN term ON (association.term_id=term.id) WHERE dbxref.xref_key = ''%s'' and term.term_type=''cellular_component'' order by term.acc asc';
    
    sql = sprintf(sqlformat,swissprotid);
    curs = exec(conn,sql);
    curs = fetch(curs);
    go = curs.Data;
    close(curs);
end

