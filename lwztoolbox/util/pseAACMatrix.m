%函数pseAACMatrix(fastaFile,option)把文件中的每个蛋白质序列转化为伪氨基酸成分向量
%fastaFile: 蛋白质序列文件，fasta格式
%option: 生成伪氨基酸成分选项，
%       -‘Chou'：Chou的生成伪氨基酸成分的方法
%       -'GM1':灰色模型GM(1,1)生成伪氨基酸成分的方法
%       -'GM2'：灰色模型GM(2,1)生成伪氨基酸成分的方法
%optionVal: 对应生成伪氨基酸成分的参数
%       -'Chou'对应的值是lamda的取值，每个蛋白质表示为20+lamda维的向量
%       -'GM1'和 GM2对应的值表示氨基酸序列编码代号，见AACode函数；
%data： 函数返回值是L*M矩阵，L表示文件中蛋白质序列的总数，M是伪氨基酸成分的大小
%       注意：返回的伪氨基酸矩阵中，伪氨基酸成分的权值未设置。
function data = pseAACMatrix(fastaFile,option,optionVal)
[heads,seqs] = fastaread(fastaFile);
L = length(heads);

switch option
    case 'Chou'
        data = zeros(L,20+optionVal);
        for i = 1 : L
            seq = regexprep(seqs{i},'[?bBzZxXUu]','');
            %前20个是氨基酸成分
            data(i,1:20) = AAVector(seq);
            
            %后面是Chou伪氨基酸成分            
            for r = 1 : optionVal
                data(20+r) = CorrelationFactor(seq,r);
            end
        end
        
    case 'GMl'
        data = zeros(L,22);
        seq = regexprep(seqs{i},'[?bBzZxXUu]','');
        for i = 1: L
            %前20个是氨基酸成分
            data(i,1:20) = AAVecotr(seq);

            %后面是灰色模型参数的伪氨基酸成分             
            numseq = aaseq2numseq(seq,optionVal);
            p = GMParam(numseq);
            data(i,21) = p(1);
            data(i,22) = p(2);
        end
        
    case 'GM2'
        data = zeros(L,23);
        seq = regexprep(seqs{i},'[?bBzZxXUu]','');
        for i = 1: L
            %前20个是氨基酸成分
            data(i,1:20) = AAVector(seq);

            %后面是灰色模型参数的伪氨基酸成分             
            numseq = aaseq2numseq(seq,optionVal);
            p = GM21Param(numseq);
            data(i,21) = p(1);
            data(i,22) = p(2);
            data(i,23) = p(3);
        end
end