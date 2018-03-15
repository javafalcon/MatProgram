function protein=BinarySeq2Protseq(binaryseq)
len = length(binaryseq);
p={};
k=1;
for i = 1 : 5 : len
    b=binaryseq(i:i+4);
    if sum(b ==[1 0 1 0 1]) == 5
        c='N';
        continue;
    end
    if sum(b==[1 1 0 1 0])==5
        c='V';
        continue;
    end
    if sum(b==[1 1 1 0 1])==5 
        c='E';
        continue;
    end
    if sum(b==[0 0 0 1 1])==5
        c='L';
        continue;
    end
    if sum(b== [0 0 1 0 1])==5
        c='H';
        continue;
    end
    if sum(b== [0 1 0 0 1])==5
        c='S';
        continue;
    end
    if sum(b== [0 1 0 1 1])==5
        c='F';
        continue;
    end
    if sum(b== [0 1 1 1 1])==5
        c='C';
        continue;
    end
    if sum(b== [1 0 0 1 0])==5
        c='I';
        continue;
    end
    if sum(b== [1 0 1 0 0])==5
        c='K';
        continue;
    end
    if sum(b== [1 1 0 0 1])==5
        c='A';
        continue;
    end
    if sum(b== [1 1 1 0 0])==5
        c='D';
        continue;
    end
    if sum(b== [1 1 1 1 0])==5
        c='G';
        continue;
    end
    p{k}=c;
    k = k+1;
end
protein=string(p);
    