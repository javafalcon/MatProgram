function correctCount = fisher_jackknife(data,group)
%fisherÅĞ±ğµÄjackknife²âÊÔ
row = size(data,1);
correctCount = 0;

for i = 1 : row
    train=true(row,1);
    train(i) = false;
    test = ~train;
%     [w,y0]=fisher1(data(train,:),group(train));
    w = kernelfisher(data(train,:),group(train));
    if (data(test,:) * w < y0)
        label = -1;
    else
        label = 1;
    end
    if label == group(test)
        correctCount = correctCount + 1;
    end
end
