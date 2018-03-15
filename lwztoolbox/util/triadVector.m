function triVec = triadVector(sequence)

%traidVector 把氨基酸序列转为三联体成分向量。每个氨基酸归属7个分组中的某一组，
% 这样共有7*7*7=343种类别的三联体。计算343种三联体成分在氨基酸序列中所占的比例

len = length(sequence);
triVec = zeros(343,1);

%%
% 把氨基酸序列变为编组序列，每个氨基酸属于7组中的一组，分别用0~6的数字表示
digalVec = zeros(1,len);
for i = 1 : len
    switch sequence(i)
        case {'A','G','V'}
           digalVec(i) = 0;
        case {'I','L','F','P'}
            digalVec(i) = 1;
        case {'Y','M','T','S'}
            digalVec(i) = 2;
        case {'H','N','Q','W'}
            digalVec(i) = 3;
        case {'R','K'}
            digalVec(i) = 4;
        case {'D','E'}
            digalVec(i) = 5;
        case {'C'}
            digalVec(i) = 6;
        otherwise
    end
end
%%
% 求三联体成分向量。每组三联体可以构成一个7进制的3位数，从000~666（转换为十进制
% 为从0~342）。
for i = 1 : len - 2
    x = digalVec(i);
    y = digalVec(i+1);
    z = digalVec(i+2);
    
    index = x*49 + y*7 + z + 1;
    triVec(index) = triVec(index) + 1; %三联体成分出现的次数加1。 
end

%%
% 规范化三联体成分向量
triVec = ( triVec - min(triVec)) / max(triVec);
    