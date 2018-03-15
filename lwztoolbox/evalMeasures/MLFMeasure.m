function acc = MLFMeasure( labels, predlabels )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
    N = size(labels,1);
    t = 0;
    for i = 1 : N
        v = labels(i,:) + predlabels(i,:);
        t = t + 2*sum(v==2)/(sum(labels(i,:)) + sum(predlabels(i,:)) );
    end
    
    acc = t/N;

end

