function GFaLK_SVM_independent(trainFile,testFile,k,p)
[trn_group, trn_data] = libsvmread(trainFile);
[tst_group, tst_data] = libsvmread(testFile);
[trnRow,trnCol] = size(trn_data);
[tstRow,tstCol] = size(tst_data);
if trnCol < tstCol
    trn_data(:,trnCol+1:tstCol) = zeros(trnRow,tstCol-trnCol);
elseif trnCol > tstCol
    tst_data(:,tstCol+1:trnCol) = zeros(tstRow,trnCol-tstCol);        
end
%确定用于训练的近邻数
if nargin < 3
   k = sqrt(trnRow);
   p = k;
end
%统计训练时间
tStart_train = tic;
[models, modelPtrs] = GFaLK_SVM_train( trn_data,trn_group, k, p);
tElapse_train = toc( tStart_train);

%写到文本中
fid = fopen('GreySVMresult.txt','a');
fprintf(fid, '\n[ %s ]', datestr(now));
fprintf(fid, '\nDataset file:%s and %s including %d training size and %d testing size', trainFile, testFile, trnRow, tstRow);
fprintf(fid,'\nTraining time: %f seconds',tElapse_train);

%统计预测所有样本的时间以及预测的精度
Y_pred = zeros(tstRow,1);
tStart_test = tic;
for i = 1 : tstRow
	ind = getKNNbyGID(tst_data(i,:), trn_data,1); % retrieve the nearest training point with respect to q
	[Y_pred(i), acc, dev] = svmpredict( tst_group(i), tst_data(i,:), models{modelPtrs(ind)});
%     dist = EuclDistance(trn_data,tst_data(i,:));
%     [B,IX] = sort(dist);
%     dist=CosinDistance(trn_data,tst_data(i,:));
%     [B,IX]=sort(dist,'descend');
%     ind=IX(1);
%     [Y_pred(i), acc, dev] = svmpredict( tst_group(i), tst_data(i,:), models{modelPtrs(ind)});
end
tElapse_test = toc( tStart_test);

fprintf(fid,'\nTest time: %f seconds', tElapse_test);
fprintf(fid,'\nTest accuracy: %f\n', length(find(Y_pred==tst_group))/tstRow);
fclose(fid);

	