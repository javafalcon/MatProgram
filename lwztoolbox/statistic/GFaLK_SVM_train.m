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

%         ind=EuclDistance(train_matrix,x);
%         [B,IX]=sort(ind);
%         dist=CosinDistance(train_matrix,x);
%         [B,IX]=sort(dist,'descend');
%         localPoints=IX(1:k);
        
        %[bestc,bestg,bestr]=libsvm_grid(train_matrix(localPoints,:),label(localPoints),5);
        %option=['-c ' num2str(bestc) ' -g ' num2str(bestg)];
		option = '-c 8 -g 8';
        models{c}=svmtrain(label(localPoints), train_matrix(localPoints,:),option); % train a local svm
        
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
        
        

