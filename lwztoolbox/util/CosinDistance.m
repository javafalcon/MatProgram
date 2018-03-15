%d=VectorDistance(S,P)
%��������P�ͼ���S��ÿһ�������ľ���
%���빫ʽ��(P1*P2)/(||P1||*||P2||),P1*P2�������ĵ��
function d = CosinDistance(S,P)
 m = size(S,1);
 d = zeros(1,m);
 for i = 1:m
     x = S(i,:);%S�ĵ�i������
     d(i) = dot(x,P)/(norm(x) * norm(P));
 end