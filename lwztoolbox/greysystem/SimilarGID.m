% ���ƻ�ɫ������ģ��
% SimilarGID(x,y)��������x,y֮��Ľӽ���ɫ������
function p = SimilarGID(x,y)
n = length(x);
z=(x-x(1))-(y-y(1));
u = sum( z(2:n-1)) + 0.5*z(n);
p = 1/(1+abs(u));