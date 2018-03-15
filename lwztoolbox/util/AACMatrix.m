%data=AAC(fastaFile):��fastaFile�ļ��е�ÿһ���е���������ת��Ϊһ��20D������
%data: ��������һ��L*20�ľ���L���ļ������������ʵ�������ÿ�������ǵ��������е�amino acid composition��ʾ
%fastaFile- fastag��ʽ�ĵ����������ļ�
function data=AACMatrix(fastaFile)

[heads,seqs]=fastaread(fastaFile);
L = length(heads);
data = zeros(L,20);
for i = 1 : L
    aa = aacount(seqs{i});
    aac=[aa.A aa.C aa.D aa.E aa.F aa.G aa.H aa.I aa.L aa.K aa.M aa.N aa.P aa.Q aa.R aa.S aa.T aa.V aa.W aa.Y];
    data(i,:) = aac/sum(aac);
end