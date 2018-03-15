function idx = findStrFromCell(strcell, str)
    idx = 0;
    n = length(strcell);
    for k = 1 : n
        if( strcmp(strcell{k},str) == 1)
            idx = k;
            break;
        end
    end