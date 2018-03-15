function Y_pred = libsvmtest_jk(label,instance,option,b,K)
if nargin < 4
    b = 0;
end
n = length(label);
Y_pred = zeros(n,1);
for i = 1 : n
    disp(strcat('Testing NO.',int2str(i),'-th instance'));
    indx = true(n,1);
    indx(i) = false;
    Test_X = instance(i,:);
    Train_X = instance(indx,:);
    Train_Y = label(indx);
    %% SMOTE imbalance data
    if b == 1
        idx_pos = Train_Y==1;
        ptr = Train_X(idx_pos,:);
        ntr = Train_X(~idx_pos,:);
        [posData,negData]=BiSmote(ptr,ntr,K,3);
        data = [posData;negData];
        group = [ones(size(posData,1),1);zeros(size(negData,1),1)];
        model = svmtrain(group,data,'-t 0');
    %%
    else
        model = svmtrain(Train_Y, Train_X, option);
    end
   [Y_pred(i), accuracy, dec_values] = svmpredict(label(~indx), Test_X, model);
end       