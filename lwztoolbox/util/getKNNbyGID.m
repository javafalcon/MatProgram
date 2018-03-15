function ind = getKNNbyGID(x, s, k)
% 获取x在集合s中的K个近邻,近依灰色关联度（GID）选择近邻。
% x: 行向量，一个样本
% s: 矩阵，每行表示一个样本。s和x的列数必须相等
% k: 近邻数
r = GreyIncidenceDegree(x,s);
[B,IX]=sort(r,'descend');
ind = IX(1:k);

