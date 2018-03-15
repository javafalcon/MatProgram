function f = CorrelationFactor(amino_seq, r)
temp = 0;
len = length(amino_seq);
for i = 1:len-r
    temp = temp + Correlation(amino_seq(i), amino_seq(i+r));
end
f = temp/(len-r);