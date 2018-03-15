function p = CorrelationPseAAC(amino_seq, r, w)
f=AAVector(amino_seq);
s = zeros(r,1);
for i = 1 : r
    s(i) = CorrelationFactor(amino_seq,i);
end
ts = sum(s);
p = zeros(20+r,1);
for i = 1:20
    p(i) = f(i)/(1 + w*ts);
end
for i = 21:20+r
    p(i) = w*s(i-20)/(1 + w*ts);
end