%pse=getGMPse(fileName,codeType,n)
%fileName: 文件名
%codeType:编码方式
%序列按fasta格式保存在fileName文件中。
%函数把氨基酸字符序列按编码规则转换为数字编码序列
%对数字编码序列GM(1,1)建模(n=1)，求解2个灰色参数;或GM（2,1）建模（n=2)求解3个灰色参数
%伪氨基酸序列的前20个为氨基酸成分向量
%伪氨基酸序列的后2个为GM(1,1)模型的2个参数（3个为GM(2,1)模型的3个参数）
function data=getGMPse(fileName,codeType,n)
[head,seq]=fastaread(fileName);

row = length(head);
if n == 1
    data = zeros(row,22);
elseif n == 2
    data = zeros(row,23);
end

for i = 1 : row
    pseq = regexprep(seq{i},'[?*bBzZxX]','');
    data(i,1:20) = AAVector(pseq);
    numseq = aaseq2numseq(pseq,codeType);
    if n == 1
        p = GMParam(numseq);
        data(i,21:22) = [ abs(p(1)) abs(p(2))];
    elseif n == 2
        p = GM21Param(numseq);
        data(i,21:23) = [abs(p(1)) abs(p(2)) abs(p(3))];
    end
end