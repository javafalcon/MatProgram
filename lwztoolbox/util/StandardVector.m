%author:linweizhong.2007-7-21
function sv=StandardVector(X,k)
%����cell�ͱ���X����������������ƽ������(��������
%k=0:����ȫ����������ƽ������
%k!=0:�������k������������������ƽ������

	n = length(X);%X�����������ĸ���
	m = 0;
	dimention = length(X{1});%������ά��
	sv = zeros(dimention,1);
	for i=1:n
		if i~=k
			sv = sv+X{i};
		end
	end
	if k == 0
		m = n;
	else
		m = n-1;
	end
	sv = sv/m;

