function [predicted, memberships] = fknnml(instance, labels, test, K, m, distfun)
% 多标签分类 FKNN Fuzzy k-nearest neighbor classification algorithm.
% 每个测试样本的标签数=隶属度高于阈值的标签数
%
% instance: train samples for each row vector
% labels: train samples class labels
%         ClassA  ClassB  ClassC ...
%      S1   1       0       1    ...
%      S2   1       1       0    ...
%      ...
% test: test samples for each row vector
% K: k value
% m: distance weighting
% predicted: test samples class labels
%         ClassA  ClassB  ClassC ...
%      S1   1       0       1    ...
%      S2   1       1       0    ...
%      ...
% membership: membership of test samples for each class

    num_test  = size(test,1);
    num_class = size(labels,2);
    % scaling factor for fuzzy weights.

    % convert class labels of train samples to membership vectors (between 0 and 1)
    labels = labels./repmat(sum(labels,2),1,num_class);

    % allocate space for storing predicted labels and memberships
    predicted = zeros(num_test, num_class);
    memberships = zeros(num_test, num_class);

    %% BEGIN kNN
    % for each test point, do:
    for i = 1:num_test
        dist = distance(test(i,:), instance, distfun);
        dist = dist';
        % sort the distances
        [~, indices] = sort(dist);  % 距离从小到大，对应训练样本的坐标
        neighbor_index = indices(1:K);   % 距离最小的K个训练样本的坐标
        weight = dist(neighbor_index).^(-1/(m-1));
        weight(isinf(weight)) = 1; % Some of the weights are Inf, set to 1
        test_out = weight*labels(neighbor_index,:)/sum(weight);   % 测试样本对每类的隶属度
        memberships(i,:) = test_out;
        % find predicted classes (the ones with the max. fuzzy vote)
        T = 0.30;
        predicted(i,:) = (test_out>=T)*1;
    end

end
