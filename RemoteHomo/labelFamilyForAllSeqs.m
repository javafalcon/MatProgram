[allHeads,allSeqs] = fastaread('AllFamilySeqs.fasta');
target = zeros(length(allHeads),1);
for k = 1 : 54
    file = strcat('data\\training\\Family-',num2str(k),'_P.fasta');
    [head,seq] = fastaread(file);
    for j = 1 : length(head)
        m = findStrFromCell(heads,head{j});
        target(m) = k;
    end
end
for k = 1 : 54
    file = strcat('data\\testing\\Family-',num2str(k),'_P.fasta');
    [head,seq] = fastaread(file);
    for j = 1 : length(head)
        m = findStrFromCell(heads,head{j});
        target(m) = k;
    end
end
