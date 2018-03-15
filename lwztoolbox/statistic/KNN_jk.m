%Y_pred = KNN_jk(data,group,k,distFunc)
%基于K-NN的jack-knife测试
%data 数据，每个行向量代表一个样本
%group 数据分组标签，从1开始,与data有相同的行
%k 近邻数
%distFunc 距离函数，有：
%        -cosin 余弦夹角距离
%				 -minkov 闵科夫斯基距离
%				 -gid 灰色关联度距离
%Y_pred 返回测试结果向量。

function Y_pred=KNN_jk(data,group,k,distFunc)

row = size(data,1);%样本数
Y_pred = zeros(row,1);

for i = 1 : row
	trn = true(row,1);
	trn(i) = false;
	trndata = data(trn,:);
	trngroup = group(trn);
	distance = zeros(1,row-1);
	sortoption = 'descend'; %默认下，对距离降序排序，即距离越小表示越近邻
	switch distFunc
		case 'cosin'
			for j = 1 : row-1
				distance(j) = CosAngleDistance(data(i,:),trndata(j,:));
			end
		case 'minkowski'
			for j = 1 : row-1
				distance(j) = MinkowskiDistance(data(i,:),trndata(j,:),1);%明氏距离
			end
		case 'gid'
			distance = GreyIncidenceDegree(trndata,data(i,:));
			sortoption = 'ascend';
	end
	
	[C,IX] = sort(distance,sortoption);
	
	knns = zeros(k,1);
	for n = 1 : k
		knns = length( find(trngroup(IX(1:k)) == n));
	end
	
	[v,index] = max(knns);
	
	Y_pred(i) = index; %对data(i,:)的预测结果，是K个近邻中最多的一类
end
	