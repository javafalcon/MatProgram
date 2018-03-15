function [models, modelPtrs] = GFaLK_SVM_train(train_matrix,label, k, p)
% Fast Local Kernel Support Vector Machin with grey incidence degree
% (GFaLK_SVM) trains.
% 快速的局部支持向量机的训练算法。依灰色关联度寻找近邻。
% Reference: Nicola Segata and Enrico Blanzieri, Fast and Scalable Local
% Kernel Machines, Journal of Machine Learning Research,
% 2010(11):1883-1926
% Usage:GFaLK_SVM_train(train_matrix, k, p)
% train_matrix: 训练集矩阵，每行表示一个样本
% label: 训练集样本的类别标记
% k: 局部支持向量机所需近邻数
% p: 覆盖子集的样本数
% option: 支持向量机参数
[N,M] = size(train_matrix);
modelPtrs = zeros(1,N);

models = {};

c = 1; % the counter for the centers of the models
indexes = randperm(N); % the indexes for centers selection
for i = 1 : N
    index = indexes(i);
    if modelPtrs(index) == 0 % if the point has not been assigned to a model
        x = train_matrix(index,:);
        localPoints = getKNNbyGID(x, train_matrix,k);% retrieve its k-neighbourhoods
%        [best_c,best_g,best_rate]=libsvm_grid(train_matrix(localPoints,:),label(localPoints));
%        option = ['-s 0 -t 2 -c ' num2str(best_c) ' -g ' num2str(best_g)];
        option = '-s 0 -t 1';
        models{c}=svmtrain(label(localPoints), train_matrix(localPoints,:),option); % train a local svm
%         models{c} = svmtrain(train_matrix(localPoints,:),label(localPoints),'Kernel_Function','polynomial','Method','LS');
        modelPtrs(index) = c; % assign the ceter to the trained model
        for j = 1 : p
            ind = localPoints(j);
            if modelPtrs(ind) == 0 % assign the points in the p-neighbourhoods
                modelPtrs(ind) = c;
            end 
        end
        c = c + 1;
    end % end if
end % end for
        
        

