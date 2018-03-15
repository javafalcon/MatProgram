%Y_pred = KNN_jk(data,group,k,distFunc)
%����K-NN��jack-knife����
%data ���ݣ�ÿ������������һ������
%group ���ݷ����ǩ����1��ʼ,��data����ͬ����
%k ������
%distFunc ���뺯�����У�
%        -cosin ���ҼнǾ���
%				 -minkov �ɿƷ�˹������
%				 -gid ��ɫ�����Ⱦ���
%Y_pred ���ز��Խ��������

function Y_pred=KNN_jk(data,group,k,distFunc)

row = size(data,1);%������
Y_pred = zeros(row,1);

for i = 1 : row
	trn = true(row,1);
	trn(i) = false;
	trndata = data(trn,:);
	trngroup = group(trn);
	distance = zeros(1,row-1);
	sortoption = 'descend'; %Ĭ���£��Ծ��뽵�����򣬼�����ԽС��ʾԽ����
	switch distFunc
		case 'cosin'
			for j = 1 : row-1
				distance(j) = CosAngleDistance(data(i,:),trndata(j,:));
			end
		case 'minkowski'
			for j = 1 : row-1
				distance(j) = MinkowskiDistance(data(i,:),trndata(j,:),1);%���Ͼ���
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
	
	Y_pred(i) = index; %��data(i,:)��Ԥ��������K������������һ��
end
	