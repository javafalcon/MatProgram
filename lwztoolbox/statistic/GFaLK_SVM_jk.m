function acc = GFaLK_SVM_jk(benData, group)
n = size(benData,1);
acc = 0;
prelabel = zeros(n,1);
for i=1:n
    trnlabel = true(n,1);
    trnlabel(i)=false;
    tstlabel = ~trnlabel;
    trnData = benData(trnlabel,:);
    tstData = benData(tstlabel,:);
    [models, modelPtrs]=GFaLK_SVM_train(trnData, group(trnlabel),47,43);
    m = GFaLK_SVM_test(trnData,modelPtrs,models,tstData);
    if m == group(i)
        acc = acc + 1;
    end
	prelabel(i) = m;
end
acc = acc/n;