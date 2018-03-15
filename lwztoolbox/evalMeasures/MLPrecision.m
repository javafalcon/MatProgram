function acc = MLPrecision( labels, predlabels )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
    N = size(labels,1);
    t = 0;
    for i = 1 : N
        if sum( predlabels(i,:)) > 0
            v = labels(i,:) + predlabels(i,:);
            t = t + sum(v==2)/sum(predlabels(i,:));
        end
    end
    
    acc = t/N;

end

