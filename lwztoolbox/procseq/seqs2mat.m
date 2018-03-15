%seqs�Ǵ��������ݿ��л�õ��ǵ����ʵ��ַ����У�
%����Щ�������ַ�������֯��ʽ��cell(1,row)
%row��ʾcell�а����ĵ�������Ŀ��
%������M=pseqs2matrix(seqs,codetype)
%�ѵ������ַ�������seqsת��Ϊ���ֱ�������
%M��������row,Mÿһ�б�ʾһ�������ʵ�������ʾ��
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
