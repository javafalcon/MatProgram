function data=getGMPseByAAindex(fileName,indexName,type,n)
%type: 1标准化
%n: 1: GM(1,1);2:GM(2,1)
%indexName: 参见AAindexCode
[head,seq]=fastaread(fileName);

row = length(head);
if n == 1
    data = zeros(row,22);
elseif n == 2
    data = zeros(row,23);
end

for i = 1 : row
    disp(strcat('Calculating protein:  ', head{i}));
    pseq = regexprep(seq{i},'[?*bBzZxXUuOoJj\s]','');
    data(i,1:20) = AAVector(pseq);
	len = length(pseq);
    numseq = zeros(len,1);
	for j = 1 : len
		numseq(j) = AAindexCode(pseq(j),indexName,type);
	end
    if n == 1
        p = GMParam(numseq);
        data(i,21:22) = [ abs(p(1)) abs(p(2))];
    elseif n == 2
        p = GM21Param(numseq);
        data(i,21:23) = [abs(p(1)) abs(p(2)) abs(p(3))];
    end
end