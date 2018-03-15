function [Kbest,Mbest,Abest,ConMat] = fknnGridSearchLoo(instance, label, flagscale)
% 以 LOO-ACC 为优化目标，采用grid-search算法，估计FKNN分类器的参数 k,m
%
% instance:    样本矩阵，每行代表一个样本的特征向量
% label:       样本类标签集合（列向量），与instance行对应，形式：1 ... 2 ... 3 ...
% flagscale:   是否进行数据尺度缩放的标志
% Kbest,Mbest: 搜索到的最佳参数
% Abest:       最佳参数下的 accuracy (ACC)
% ConMat:      最佳参数下的 confusion_matrix
%
% example:
% >> load heart_scale.mat
% >> [Kbest,Mbest,Abest,ConMat] = fknnGridSearchLoo(heart_scale_inst,heart_scale_label+2)

if nargin<3, flagscale = 0; end
if flagscale, instance = datascale(instance); end
Kbest = 0; Mbest = 0; Abest=0;
N = length(label);
type = max(label);
%% loose grid
disp('---------------------------------loose grid---------------------------------');
K = 3:2:15;      nK = length(K);
M = 1.01:0.2:2;  nM = length(M);
Z = [];
for i = 1:nK
    k = K(i);
    for j = 1:nM
        m = M(j);
        predicted = zeros(size(label));
        MATRIX = zeros(type,type);
        for s = 1:N
            indte = false(N,1);
            indte(s) = true;          %test indices
            indtr = ~indte;           %train indices
%             predicted(s) = fknn(instance(indtr,:), label(indtr,:), instance(indte,:), k, m);  % fknn or fknnGRG
            predicted(s) = fknnGRG(instance(indtr,:), label(indtr,:), instance(indte,:), k, m);
            MATRIX(label(s), predicted(s)) = MATRIX(label(s), predicted(s)) + 1;
        end
        Nh = sum(predicted==label);
        acc = Nh/N;
        Z(j,i) = acc;
        if Abest < acc
            Kbest = k; Mbest = m; Abest = acc;
            ConMat = MATRIX;
        end
        fprintf('k=%d & m=%.2f ===> ACC: %d/%d = %.2f%%.\n', k, m, Nh, N, acc*100);
    end
end
[X,Y] = meshgrid(K,M);
figure; surf(X,Y,Z);
xlabel('k');
ylabel('m');
zlabel('ACC');

[Kbest,Mbest,Abest]
%% fine grid
disp('----------------------------------fine grid---------------------------------');
K = Kbest-2:1:Kbest+2;  nK = length(K);
M = Mbest-0.2:0.05:Mbest+0.2;  nM = length(M);
Z = [];
for i = 1:nK
    k = K(i);
    for j = 1:nM
        m = M(j);
        predicted = zeros(size(label));
        MATRIX = zeros(type,type);
        for s = 1:N
            indte = false(N,1);
            indte(s) = true;          %test indices
            indtr = ~indte;           %train indices
            predicted(s) = fknn(instance(indtr,:), label(indtr,:), instance(indte,:), k, m);
            MATRIX(label(s), predicted(s)) = MATRIX(label(s), predicted(s)) + 1;
        end
        Nh = sum(predicted==label);
        acc = Nh/N;
        Z(j,i) = acc;
        if Abest < acc
            Kbest = k; Mbest = m; Abest = acc;
            ConMat = MATRIX;
        end
        fprintf('k=%d & m=%.2f ===> ACC: %d/%d = %.2f%%.\n', k, m, Nh, N, acc*100);
    end
end
[X,Y] = meshgrid(K,M);
figure; surf(X,Y,Z);
xlabel('k');
ylabel('m');
zlabel('ACC');

end
