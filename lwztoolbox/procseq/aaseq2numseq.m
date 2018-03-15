%numseq = aaseq2numseq(aaseq,codeType)
%把氨基酸字符序列转换为数值编码的列向量
%aaseq:氨基酸字符序列
%codeType:编码格式
function numseq = aaseq2numseq(aaseq,codeType)
len = length(aaseq);
numseq = zeros(len,1);
for i = 1 : len
    numseq(i) = AACode(aaseq(i),codeType);
end