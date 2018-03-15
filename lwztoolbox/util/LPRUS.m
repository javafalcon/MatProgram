function [X,Y] = LPRUS( data, groups, P )
%LP-RUS is a multi-label undersampling method that deletes random samples
%of majority labelsets.
%data: multi-label dataset including N samples.
%groups: label set, N by M matrix.
%P: reduction size
    [N,M] = size(groups);
    samplesToDelete = N * P;
    %% Group samples according to their labelsets
    labelSetBagIndex = cell(M,1);
    for i = 1 : M
        indx = find(groups(:,i));
        labelSetBagIndex{i} = indx;
    end
    %% Calculate the average number of samples per labelset
    meanSize = 0;
    for i = 1 : M
        meanSize = meanSize + length(labelSetBagIndex{i});
    end
    meanSize = meanSize/M;
    %% Obtain majority labels bags
    majBagIndex = [];
    for i = 1 : M
        if length(labelSetBagIndex{i}) > meanSize
            majBagIndex = [majBagIndex, i];
        end
    end
    meanReduction = round(samplesToDelete/length(majBagIndex));
    %% Calculate # of instances to delete and remove them
    for i = majBagIndex
        r = length(labelSetBagIndex{i});
        index = true(r,1);
        reductionBag = min( r - meanSize, meanReduction);
        for n = 1 : reductionBag
            x = randi(r);
            index(x) = false;
        end
        labelSetBagIndex{i} = labelSetBagIndex{i}(index);
    end
    %% Reorganize dataset and its labelset
    ix = [];
    for i = 1 : M
        for j = 1 : length(labelSetBagIndex{i})
            if isempty(find(ix==labelSetBagIndex{i}(j)))
                ix = [ix; labelSetBagIndex{i}(j)];
            end
        end
    end
    X = data(ix,:);
    Y = groups(ix,:);
end

