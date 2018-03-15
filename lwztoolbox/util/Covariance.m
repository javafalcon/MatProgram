%author:linweizhong
%data:2007-7-21
%求cell型变量X包含的所有向量的协方差矩阵
%k=0:计算全体列向量的协方差矩阵
%k!=0:计算除第k个向量外其余向量的协方差矩阵
function cv=Covariance(X,k)
	n = length(X);%求集合X包含列向量的个数
	m = 0;
	dimention = length(X{1});%求列向量的维数
	cv = zeros(dimention,dimention);%协方差矩阵
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
