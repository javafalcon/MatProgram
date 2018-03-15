%pse=getGMPse(fileName,codeType,n)
%fileName: �ļ���
%codeType:���뷽ʽ
%���а�fasta��ʽ������fileName�ļ��С�
%�����Ѱ������ַ����а��������ת��Ϊ���ֱ�������
%�����ֱ�������GM(1,1)��ģ(n=1)�����2����ɫ����;��GM��2,1����ģ��n=2)���3����ɫ����
%α���������е�ǰ20��Ϊ������ɷ�����
%α���������еĺ�2��ΪGM(1,1)ģ�͵�2��������3��ΪGM(2,1)ģ�͵�3��������
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