function ind = getKNNbyGID(x, s, k)
% ��ȡx�ڼ���s�е�K������,������ɫ�����ȣ�GID��ѡ����ڡ�
% x: ��������һ������
% s: ����ÿ�б�ʾһ��������s��x�������������
% k: ������
r = GreyIncidenceDegree(x,s);
[B,IX]=sort(r,'descend');
ind = IX(1:k);

