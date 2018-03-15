function D=CA(Protseq,N,NumOfRule)
%Protseq: protein sequence
%N:演化次数
%NumOfRule:演化规则
binaryseq = BinaryProtSeq(Protseq);
len = length(binaryseq);
D=zeros(N,len);
D(1,:)=binaryseq;
BinRule=dec2bin(NumOfRule,8);
for i=2:N
    D(i,1)=BinaryCellIterate(D(i-1,len),D(i-1,1),D(i-1,2),BinRule);
    D(i,len)=BinaryCellIterate(D(i-1,len-1),D(i-1,len),D(i-1,1),BinRule);
    for j = 2:len-1
        D(i,j)=BinaryCellIterate(D(i-1,j-1),D(i-1,j),D(i-1,j+1),BinRule);
    end
end
    
