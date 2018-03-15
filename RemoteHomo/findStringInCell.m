function k = findStringInCell(C, str)
    for i = 1 : length(C)
        if startsWith(C{i},str)
            k = i;
            break;
        end
    end
end