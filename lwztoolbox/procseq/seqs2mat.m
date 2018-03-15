%seqs是从网上数据库中获得的是蛋白质的字符序列，
%且这些蛋白质字符序列组织形式是cell(1,row)
%row表示cell中包含的蛋白质数目。
%函数：M=pseqs2matrix(seqs,codetype)
%把蛋白质字符序列组seqs转换为数字编码数组
%M的行数是row,M每一行表示一个蛋白质的向量表示。
function M = seqs2mat(seqs,codetype)
row = size(seqs,2);
tpl = length(codetype);
col = 20+tpl*3;

M = zeros(row,col);

for i = 1 : row
    pseq = seqs{i};
    pseq = regexprep(pseq,'[?bBzZxX]','');
    x = AAVector(pseq);
    M(i,1:20) = x;
    k = 20;
    for j = 1 : tpl
        numseq = aaseq2numseq(pseq,codetype(j));
%         param = GMParam(numseq);
        param = GM21Param(numseq);
        M(i,k+1) = abs(param(1));
        M(i,k+2) = abs(param(2));
        M(i,k+3) = abs(param(3));
        k = k + 3;
    end
end
