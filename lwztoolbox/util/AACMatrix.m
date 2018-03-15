%data=AAC(fastaFile):把fastaFile文件中的每一个有蛋白质序列转化为一个20D的向量
%data: 函数返回一个L*20的矩阵，L是文件中所含蛋白质的数量。每行向量是蛋白质序列的amino acid composition表示
%fastaFile- fastag格式的蛋白质序列文件
function data=AACMatrix(fastaFile)

[heads,seqs]=fastaread(fastaFile);
L = length(heads);
data = zeros(L,20);
for i = 1 : L
    aa = aacount(seqs{i});
    aac=[aa.A aa.C aa.D aa.E aa.F aa.G aa.H aa.I aa.L aa.K aa.M aa.N aa.P aa.Q aa.R aa.S aa.T aa.V aa.W aa.Y];
    data(i,:) = aac/sum(aac);
end