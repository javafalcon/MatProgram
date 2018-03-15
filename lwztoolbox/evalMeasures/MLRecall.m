function acc = MLRecall( labels, predlabels )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
    N = size(labels,1);
    t = 0;
    for i = 1 : N
        v = labels(i,:) + predlabels(i,:);
        t = t + sum(v==2)/sum(labels(i,:));
    end
    
    acc = t/N;

end

