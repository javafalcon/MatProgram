function auc=auc(FPR, TPR)
    [x2,inds]=sort(FPR);
    x2=[x2,1];
    y2=TPR(inds);
    y2=[y2,1];
    xdiff=diff(x2);
    xdiff=[x2(1),xdiff];
    auc1=sum(y2.*xdiff);
    auc2=sum([0,y2([1:end-1])].*xdiff);
    auc=mean([auc1,auc2]);
end
