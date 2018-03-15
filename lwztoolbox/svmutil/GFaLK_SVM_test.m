function classes = GFaLK_SVM_test(train_matrix,modelPtrs, models, q)
% 快速的局部支持向量机的预测
% Usge:FaLK_SVM_test(train_matrix, modelPtrs, models, q)
% train_matrix: 训练集
% modelPtrs: points-to-model pointers
% params: parameter of svm in the modelPtrs
% q: 测试样本
row = size(q,1);
classes = zeros(row,1);
for j = 1 : row
    ind = getKNNbyGID(q(j,:), train_matrix,1); % retrieve the nearest training point with respect to q
% classes(j) = svmclassify(models{modelPtrs(ind)},q(j,:));
    [classes(j),acc,dev]=svmpredict([0],q(j,:),models{modelPtrs(ind)});
end
