function accuracy = svmknntrain2(learn_label, learn_inst, option)
%基于关联度的支持向量机。先求支持向量，再对支持向量用knn
%Usage: predict_label = svmknntrain2(learn_label, learn_inst, option)
%       learn_label: m lines by one column 数组。训练集样本的分类标记数组
%       learn_inst: m lines by n columns 矩阵。训练样本
%       option: '-v foldval -k kval -f fval'
%                foldval: 交叉验证的折叠数
%                kval：近邻数
%                fval：函数名称。grd-灰关联度；euler-欧式距离
%       predict_label: 预测的分类标记
m = size(learn_inst,1);

% set the default value of argv
nfold = 5;
k = 20;

if nargin < 3 %参数不足
    error('Error arguments');
end

% 分析命令参数
optargs = regexpi(option,'\s','split');

for j = 1 : 2: length(optargs)
    pname = optargs{j};
    pval = optargs{j+1};
    switch (pname)
        case '-v'
            nfold = eval(pval);
            cross_valid = 1;
        case '-k'
            k = eval(pval);
            if k > m
                error('K value is exceed');
            end
        case '-f'
            switch (pval)
                case 'grd'
                    fun = @GreyIncidenceDegree;
                case 'euler'
                    fun = @Euler;
                otherwise
                    error('Unknown distance function');
            end
        otherwise
            error('Unknown parameter');
    end
end

correct = 0;
indices = crossvalind('Kfold', m, nfold);
for ii = 1 : nfold
    test_indices = ( indices == ii);
    train_indices = ~test_indices;
    testlab = learn_label( test_indices);
    trainlab = learn_label( train_indices);
    testinst = learn_inst( test_indices,:);
    traininst = learn_inst( train_indices,:);
    predict_label = svmknnpredict2([],testinst,trainlab,traininst,option);
    correct = correct + length(testlab)-nnz(predict_label-testlab);
%     for jj = 1 : length(testlab)
%         test = testinst(jj,:);
%         predict_label = svmknnpredict2([],test,trainlab,traininst,option);
%         if predict_label == testlab(jj)
%            correct = correct + 1;
%         end
%     end
end
accuracy = correct/m;
