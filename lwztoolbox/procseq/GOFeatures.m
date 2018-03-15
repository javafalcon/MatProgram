function data = GOFeatures( conn,fname,blastdbname )
    sql  = 'select distinct acc from term where acc like ''GO:%'' and term_type=''cellular_component'' ';
    curs = exec(conn, sql);
    curs = fetch(curs);
    AllGO = curs.Data();%All Gene Ontology annotations list
    close(curs);
    
    M = length(AllGO);
    
    [heads,seqs] = fastaread(fname);
    N = size(heads,2);
    
    data = zeros(N,M);
    
    for i = 1 : N
        
        disp(int2str(i));
        %list all homologous proteins of seqs{i} by using blastp
        prots = getHomologousProts(seqs{i},'blastdbname',blastdbname);
        
        if ~isempty(prots)
            j = 1;
            while (j <= length(prots) )
                %list Gene Ontology annotations of the j-th protein in prots
                pid = prots(j);
                go = getGO4Prot(conn,pid{1});

                for x = 1 : size(go,1);
                    %find the index of x-th GO annotation in AllGO list
                    indx = strcmp(go{x}, AllGO);
                    m = find(indx);
                    data(i,m) = data(i,m) + 1;
                end
                j = j + 1;
            end
            data(i,:) = data(i,:) / (j-1);
        end
    end
        

end

