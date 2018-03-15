function predict_label = svmknnpredict2(test_label,test_inst, learn_label, learn_inst, option)
%基于关联度的支持向量机。先求支持向量，再对支持向量用knn
%Usage: predict_label = grd_svm_predict2(test_label,test_inst, learn_label,learn_inst, option)
%       test_label: s lines by one column 数组。测试集样本的分类标记数组。如果不是做交叉验证，则为[]。
%       test_inst: s lines by p columns 矩阵。测试样本。如果不是做交叉验证，则为[]
%       learn_label: m lines by one column 数组。训练集样本的分类标记数组
%       learn_inst: m lines by n columns 矩阵。训练样本
%       option: '-v foldval -k kval -f fval'
%                foldval: 交叉验证的折叠数
%                kval：近邻数
%                fval：函数名称。grd-灰关联度；euler-欧式距离
%       predict_label: 预测的分类标记
[best_c,best_g,best_rate]=libsvm_grid(learn_inst,learn_label,5);
argv=['-s 0 -t 2 -c ' num2str(best_c) ' -g ' num2str(best_g)];
model=svmtrain(learn_label,learn_inst,argv);

s = size(test_inst,1);
m = size(learn_inst,1);
predict_label = zeros(s,1);
% set the default value of argv
k = 20;
fun = @GreyIncidenceDegree;

if nargin < 5 %参数不足
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

for i = 1 : s
    test = test_inst(i,:);
    dist = fun(test,model.SVs);
    [B,IX] = sort(dist,'descend');
    [M,F] = mode(learn_label( IX(1:k)));
    predict_label(i) = M;
end
if ~isempty(test_label)
fprintf('Accuracy=%f%\n',100*sum(predict_label-test_label)/s);
end
