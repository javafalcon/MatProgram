%author:linweizhong.2007-7-21
function sv=StandardVector(X,k)
%计算cell型变量X包含的所有向量的平均向量(列向量）
%k=0:计算全体列向量的平均向量
%k!=0:计算除第k个向量外其余向量的平均向量

	n = length(X);%X所含列向量的个数
	m = 0;
	dimention = length(X{1});%向量的维数
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

