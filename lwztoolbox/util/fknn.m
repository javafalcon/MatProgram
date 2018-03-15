function [predicted, memberships] = fknn(data, labels, test, K, m)
% FKNN Fuzzy k-nearest neighbor classification algorithm.
%
% data: train sample for each row vector
% labels: train samples class labels
% test: test samples
% K: k value
% m: distance weighting
% 
% predicted: test samples predicted class labels
% membership: membership of test samples for each class

num_train = size(data,1);
num_test  = size(test,1);

% scaling factor for fuzzy weights. see [1] for details
if nargin<5, m = 2; end

% convert class labels to unary membership vectors (of 1s and 0s),采用确定性分类标号
max_class = max(labels);
temp = zeros(length(labels), max_class);
for i = 1:num_train
    temp(i,:) = [zeros(1,labels(i)-1) 1 zeros(1,max_class-labels(i))];
end
labels = temp;
clear temp;

% allocate space for storing predicted labels 
predicted = zeros(num_test, 1);

% will the memberships be stored? if yes, allocate space
store_memberships = false;
if nargout > 1
    store_memberships = true;
    memberships = zeros(num_test, max_class);
end

%% BEGIN kNN
% for each test point, do:
for i = 1:num_test
    distances = (repmat(test(i,:),num_train,1) - data).^2;
    % for efficiency, no need to take sqrt since it is a non-decreasing function
    distances = sum(distances,2)';
    % sort the distances
    [~, indeces] = sort(distances);  % 从小到大
    neighbor_index = indeces(1:K);
    weight = distances(neighbor_index).^(-1/(m-1));
    weight(isinf(weight)) = 1; % Some of the weights are Inf, set to 1
    test_out = weight*labels(neighbor_index,:)/(sum(weight));
    if store_memberships, memberships(i,:) = test_out; end;
    % find predicted class (the one with the max. fuzzy vote)
    [~, index_of_max] = max(test_out);
    predicted(i) = index_of_max;
end
end
