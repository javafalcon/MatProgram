%numseq = aaseq2numseq(aaseq,codeType)
%�Ѱ������ַ�����ת��Ϊ��ֵ�����������
%aaseq:�������ַ�����
%codeType:�����ʽ
function numseq = aaseq2numseq(aaseq,codeType)
len = length(aaseq);
numseq = zeros(len,1);
for i = 1 : len
    numseq(i) = AACode(aaseq(i),codeType);
end