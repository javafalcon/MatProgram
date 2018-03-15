function predict_label = grd_svm_predict1(test_label,test_inst, learn_label, learn_inst, option)
%���ڹ����ȵ�֧��������
%Usage: predict_label = grd_svm_predict(test_label,test_inst, learn_label,learn_inst, option)
%       test_label: s lines by one column ���顣���Լ������ķ��������顣���������������֤����Ϊ[]��
%       test_inst: s lines by p columns ���󡣲������������������������֤����Ϊ[]
%       learn_label: m lines by one column ���顣ѵ���������ķ���������
%       learn_inst: m lines by n columns ����ѵ������
%       option: '-v foldval -k kval -f fval'
%                foldval: ������֤���۵���
%                kval��������
%                fval���������ơ�grd-�ҹ����ȣ�euler-ŷʽ����
%       predict_label: Ԥ��ķ�����
s = length(test_inst);
m = length(learn_inst);

% set the default value of argv
nfold = 5;
cross_valid = 0;
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

% ������֤Ԥ�����
if isempty(test_inst)
    correct = 0;
    predict_label = zeros(m,1);
    if cross_valid == 0 % self-consistence ��֤
        for ii = 1 : m
            predict_label(ii) = grdsvm(learn_inst(ii,:), learn_label, learn_inst);
            if predict_label(ii) == learn_label(ii)
                correct = correct + 1;
            end
        end  
        accuracy = correct/m;
        fprintf('Accuracy=%f\n', accuracy);
    else % K-fold������֤
        correct = 0;
        indices = crossvalind('Kfold', m, nfold);
        for ii = 1 : nfold
           
           test_indices = ( indices == ii);
           train_indices = ~test_indices;
           testlab = learn_label( test_indices);
           trainlab = learn_label( train_indices);
           testinst = learn_inst( test_indices,:);
           traininst = learn_inst( train_indices,:);
           for jj = 1 : length(testlab)
               test = testinst(jj,:);
               predict_label = grdsvm(test,trainlab,traininst);
               if predict_label == testlab(jj)
                   correct = correct + 1;
               end
           end
%            accuracy = accuracy + correct/length(testlab);
        end
        accuracy = correct/m;%accuracy = accuracy/nfold;
        fprintf('Accuracy=%f\n', accuracy);
     end
end

% �������Լ�Ԥ��
if nargin == 6 
    predict_label = zeros(s,1);
    for ii = 1 : s
       predict_label(ii)=grdsvm(test_inst(ii,:), learn_label, learn_inst); 
    end
    
    if ~isemptyp(test_label)
        correct = 0;
        for ii = 1 : s
            if predict_label(ii) == test_label(ii)
                correct = correct + 1;
            end
        end
        accuracy = correct/s;
        fprintf('Accuracy=%f\n',accuracy);
    end
    
end


% grdsvm: subfunction to predict test's label
function prelabel = grdsvm(test,train_label,train_inst)
    %����test��ѵ����train_inst��ÿһ�������ľ���
    pn = length(train_label);
    dist = fun(test, train_inst);
    [B,IX] = sort(dist,'descend');

%     right = 0;
%     %��K������ڵķ�����
%     for l = 2 : k
%         if train_label(IX(l)) == train_label(IX(1))
%             right = right + 1;
%          end
%     end

    % ���k�������У����Զ�����>3/4)�Ľ�������ͬһ�࣬���test��Ϊ����
    [M,F] = mode(train_label( IX(1:k)));
    if F  >= k*2/3
        prelabel = M;
        fprintf('predict by knn\n')
        return
    end
    %������svm�б�test�����svm��ѵ�������Ǹ�k������
%     model = svmtrain(train_label( IX( k+1:pn)), train_inst( IX(k+1:pn),:), '-s 0 -t 2 -c 8 -g 0.125');
    model = svmtrain(train_label( IX( 1:k)), train_inst( IX(1:k),:), '-s 0 -t 2 -c 8 -g 0.125');
    [prelabel, ac, dec_values] = svmpredict([1],test,model);
 
end

end