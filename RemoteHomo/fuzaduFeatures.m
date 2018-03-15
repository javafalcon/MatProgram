% param:
%   Proseq: protien sequence
%   Rule: a 1-by-N vector
%   NT: the number of iterator
% return:
%   y: a 1-by-N vector
function y=fuzaduFeatures(Proseq,Rule,TN)
    binaryseq = BinaryProtSeq(Proseq);
    seqlen = length(binaryseq);
    
    N = length(Rule);
    y = zeros(1,N);
    k = 1;
    for rule = Rule
        D = zeros(TN,seqlen);
        D(1,:) = binaryseq;
        BinRule = dec2bin(rule,8);
        for i = 2 : N
            D(i,1) = BinaryCellIterate(D(i-1,seqlen),D(i-1,1),D(i-1,2),BinRule);
            D(i,seqlen) = BinaryCellIterate(D(i-1,seqlen-1),D(i-1,seqlen),D(i-1,1),BinRule);
            for j = 2 : seqlen-1
                D(i,j) = BinaryCellIterate(D(i-1,j-1),D(i-1,j),D(i-1,j+1),BinRule);
            end
        end
        y(k) = fuzadu(D(N,:));
        k = k + 1;
    end