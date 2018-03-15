function classes = GFaLK_SVM_test(train_matrix,modelPtrs, models, q)
% ���ٵľֲ�֧����������Ԥ��
% Usge:FaLK_SVM_test(train_matrix, modelPtrs, models, q)
% train_matrix: ѵ����
% modelPtrs: points-to-model pointers
% params: parameter of svm in the modelPtrs
% q: ��������
row = size(q,1);
classes = zeros(row,1);
for j = 1 : row
    ind = getKNNbyGID(q(j,:), train_matrix,1); % retrieve the nearest training point with respect to q
% classes(j) = svmclassify(models{modelPtrs(ind)},q(j,:));
    [classes(j),acc,dev]=svmpredict([0],q(j,:),models{modelPtrs(ind)});
end
