function bs = BinaryProtSeq(sequence)
len = length(sequence);
bs = zeros(1,5*len);
for i = 1 : len
    aa = sequence(i);
    bs(5*i-4:5*i) = AABinaryCode(aa);
end
    