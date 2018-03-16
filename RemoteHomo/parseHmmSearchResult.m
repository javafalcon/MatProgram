[heads,seqs] = fastaread('3187seqs.fasta');
fid = fopen('tblout','r');
tline = fgetl(fid);
hmmscore = ones(3187,3187);
while (ischar(tline) && ~isempty(tline))
    if( startsWith(tline, '#'))
        continue;
    else
        A = textscan(tline,'%s %s %s %s %f %f %f %f %f %f %f %f %f %f %f %f %f %f %s');
        targetProtein = A(1);
        queryProtein = A(3);
        i = findStrFromCell(heads, queryProtein);
        j = findStrFromCell(heads, targetProtein)
        hmmscore(i,j) = A(6);
    end
end
