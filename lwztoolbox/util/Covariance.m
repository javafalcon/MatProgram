%author:linweizhong
%data:2007-7-21
%��cell�ͱ���X����������������Э�������
%k=0:����ȫ����������Э�������
%k!=0:�������k������������������Э�������
function cv=Covariance(X,k)
	n = length(X);%�󼯺�X�����������ĸ���
	m = 0;
	dimention = length(X{1});%����������ά��
	cv = zeros(dimention,dimention);%Э�������
	sv = StandardVector(X,k);
	for i = 1:n
		if i~=k
			cv = cv + (X{i}-sv)*(X{i}-sv)';
		end
    end
    
    if k == 0
		m = n-1;
	else
		m = n-2;
	end

	cv = cv/m;
