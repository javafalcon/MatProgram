function [predicted, HamLoss, ACC, ABACC, Pre, Rec] = fknnmlLOO(instance, label, varargin)
% 根据参数k,m计算ML-FKNN的LOO成功率
%
% instance:    样本矩阵，每行代表一个样本的特征向量
% label:       样本类标签集合，与instance行对应
%         ClassA  ClassB  ClassC ...
%      S1   1       0       1    ...
%      S2   1       1       0    ...
%      ...

 pnames = {'K','MDW','SMOTE','Amount', 'Snn', 'Loop', 'LN', 'Distance'};
 dflts = {21,2,true,3,7,false,10,'euclidean'};
 [k,m,smote,amount,snn,loop,ln,distfun] = internal.stats.parseArgs( pnames, dflts, varargin{:});
    
[N, C] = size(label);
%% LOO Cross-Validation
predicted = zeros(size(label));
if smote
    for s = 1:N
        disp(s);
        indte = false(N,1);
        indte(s) = true;          %test indices
        indtr = ~indte;           %train indices
        [synX, synY] = MLSMOTE( instance(indtr,:), label(indtr,:), 'Amount', amount, 'K', snn, 'Loop', loop, 'LN', ln,'Distance',distfun);
        predicted(s,:) = fknnml(synX,synY,instance(indte,:),k,m,distfun);
    end
else
    for s = 1:N
        disp(s);
        indte = false(N,1);
        indte(s) = true;          %test indices
        indtr = ~indte;           %train indices
        predicted(s,:) = fknnml(instance(indtr,:), label(indtr,:), instance(indte,:), k, m,distfun);
    end
end

ABACC = sum(all(predicted==label,2))/N;   %绝对准确率
ACC = MLAccuracy(label,predicted);
HamLoss = sum(sum(xor(predicted,label)))/(N*C);    %汉明损失
Pre = MLPrecision(label,predicted);
Rec = MLRecall(label,predicted);

end
