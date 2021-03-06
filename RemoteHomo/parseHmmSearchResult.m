[heads,seqs] = fastaread('3187seqs.fasta');
fid = fopen('tblout','r');
tline = fgetl(fid);
hmmscore = ones(3187,3187);
while (ischar(tline) && ~isempty(tline))
    if( startsWith(tline, '#'))
        tline = fgetl(fid);
        continue;
    else
        A = split(tline);
        targetProtein = A(1);
        queryProtein = A(3);
        i = findStringInCell(heads, queryProtein);
        j = findStringInCell(heads, targetProtein);
        hmmscore(i,j) = str2double(A(6));
        disp([queryProtein, targetProtein, num2str(hmmscore(i,j))]);
        tline = fgetl(fid);
    end
end
fclose(fid);
