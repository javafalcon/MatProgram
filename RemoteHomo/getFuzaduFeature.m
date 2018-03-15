[heads,seqs]=fastaread('3187seqs.fasta');
len = length(seqs);
fzd = zeros(len,7);
Rule = [17 43 73 107 157 193 251];
for i = 1 : len
    i
    fzd(i,:) = fuzaduFeatures(seqs{i},Rule,15);
  end
save 3187sequences_fuzadaFeatures.mat fzd