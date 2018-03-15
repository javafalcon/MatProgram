%inputfile: fasta格式的文件
%使用灰色模型GM(2,1)
function GreyPSSM=Grey_PSSM_2(inputFile)

[heads,seqs]=fastaread(inputFile);
pssm=blastpssm(inputFile,'E:/NCBI/blast-2.2.25+/db/swissprot');
if ~ischar(heads)
    len = length(heads);
    GreyPSSM = zeros(len,60);
    for i = 1 : len
        matrix = 1./(1+exp(pssm{i}(:,1:20)));
        v = AAVector(seqs{i});
        for j = 1 : 20
            p = GM21Param(matrix(:,j));
            GreyPSSM(i,-2+j*3:j*3) = [abs(p(1)) abs(p(2)) abs(p(3))]*v(j);
        end
    end
else
   GreyPSSM = zeros(1,60);
   matrix = 1./(1+exp(pssm(:,1:20)));
   v = AAVector(seqs);
   for j = 1 : 20
        p = GM21Param(matrix(:,j));
        GreyPSSM(-2+j*3:j*3) = [abs(p(1)) abs(p(2)) abs(p(3))]*v(j);
   end
end