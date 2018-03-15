function predict_label = svmknnpredict2(test_label,test_inst, learn_label, learn_inst, option)
%���ڹ����ȵ�֧��������������֧���������ٶ�֧��������knn
%Usage: predict_label = grd_svm_predict2(test_label,test_inst, learn_label,learn_inst, option)
%       test_label: s lines by one column ���顣���Լ������ķ��������顣���������������֤����Ϊ[]��
%       test_inst: s lines by p columns ���󡣲������������������������֤����Ϊ[]
%       learn_label: m lines by one column ���顣ѵ���������ķ���������
%       learn_inst: m lines by n columns ����ѵ������
%       option: '-v foldval -k kval -f fval'
%                foldval: ������֤���۵���
%                kval��������
%                fval���������ơ�grd-�ҹ����ȣ�euler-ŷʽ����
%       predict_label: Ԥ��ķ�����
[best_c,best_g,best_rate]=libsvm_grid(learn_inst,learn_label,5);
argv=['-s 0 -t 2 -c ' num2str(best_c) ' -g ' num2str(best_g)];
model=svmtrain(learn_label,learn_inst,argv);

s = size(test_inst,1);
m = size(learn_inst,1);
predict_label = zeros(s,1);
% set the default value of argv
k = 20;
fun = @GreyIncidenceDegree;

if nargin < 5 %��������
    error('Error arguments');
end

% �����������
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
