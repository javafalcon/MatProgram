function classes = GFaLK_SVM_test(train_matrix,modelPtrs, models, q)
% ���ٵľֲ�֧����������Ԥ��
% Usge:FaLK_SVM_test(train_matrix, modelPtrs, models, q)
% train_matrix: ѵ����
% modelPtrs: points-to-model pointers
% params: parameter of svm in the modelPtrs
% q: ��������

ind = getKNNbyGID(q, train_matrix,1); % retrieve the nearest training point with respect to q
[classes, acc, dev] = svmpredict(-1,q,models{modelPtrs(ind)});
