%vec = PseAAVector(w,AAVector,PseVector)
%求蛋白质序列的伪氨基成分表示向量
% AAVector--氨基酸成分，是cell(1,type)型变量，type表示分类种数
% PseVector--伪氨基酸成分，是cell(1,dim)型变量，dim表示伪氨基酸成分的个数
% w--伪氨基酸对应的权重，(1,dim)型向量，dim表示伪氨基酸成分的个数。

function vec = PseAAVector(w,AAVector,PseVector)
    type = size(AAVector,2);
    vec = cell(1,type);
    dim = length(PseVector{1}{1});
    for i=1:type
        for j = 1:size(AAVector{i},2) 
            vec{i}{j} = zeros(20+dim,1);
            for k = 1:20
                vec{i}{j}(k) = AAVector{i}{j}(k);
            end
            for k = 21:20+dim
                vec{i}{j}(k) = PseVector{i}{j}(k-20)*w(k-20);
            end
            
            s = sum(vec{i}{j});
            vec{i}{j} = vec{i}{j}/s;
        end
    end
    