function classes = GFaLK_SVM_test(train_matrix,modelPtrs, models, q)
% 快速的局部支持向量机的预测
% Usge:FaLK_SVM_test(train_matrix, modelPtrs, models, q)
% train_matrix: 训练集
% modelPtrs: points-to-model pointers
% params: parameter of svm in the modelPtrs
% q: 测试样本

ind = getKNNbyGID(q, train_matrix,1); % retrieve the nearest training point with respect to q
[classes, acc, dev] = svmpredict(-1,q,models{modelPtrs(ind)});
