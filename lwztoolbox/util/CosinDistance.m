%d=VectorDistance(S,P)
%计算向量P和集合S中每一个向量的距离
%距离公式：(P1*P2)/(||P1||*||P2||),P1*P2是向量的点积
function d = CosinDistance(S,P)
 m = size(S,1);
 d = zeros(1,m);
 for i = 1:m
     x = S(i,:);%S的第i行向量
     d(i) = dot(x,P)/(norm(x) * norm(P));
 end