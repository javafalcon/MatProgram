function accuracy = svmknntrain2(learn_label, learn_inst, option)
%���ڹ����ȵ�֧��������������֧���������ٶ�֧��������knn
%Usage: predict_label = svmknntrain2(learn_label, learn_inst, option)
%       learn_label: m lines by one column ���顣ѵ���������ķ���������
%       learn_inst: m lines by n columns ����ѵ������
%       option: '-v foldval -k kval -f fval'
%                foldval: ������֤���۵���
%                kval��������
%                fval���������ơ�grd-�ҹ����ȣ�euler-ŷʽ����
%       predict_label: Ԥ��ķ�����
m = size(learn_inst,1);

% set the default value of argv
nfold = 5;
k = 20;

if nargin < 3 %��������
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
