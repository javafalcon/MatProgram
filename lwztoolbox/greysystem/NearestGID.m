% �ӽ���ɫ������ģ��
% NearestGID(x,y)��������x,y֮��Ľӽ���ɫ������
function p = NearestGID(x,y)
n = length(x);
z=x-y;
u = sum( z(2:n-1)) + 0.5*(z(1) + z(n));
p = 1/(1+abs(u));