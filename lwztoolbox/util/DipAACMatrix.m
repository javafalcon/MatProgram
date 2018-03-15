function data = DipAACMatrix( fastaFile )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
    [heads,seqs]=fastaread(fastaFile);
    L = length(heads);
    data = zeros(L,400);
    AA = 'ACDEFGHILKMNPQRSTVWY';
    for i = 1 : L
        for k = 1 : 20
            for j = 1 : 20
                c = regexp(seqs{i},[AA(k) AA(j)]);
                data(i,k*j) = length(c);
            end
        end
        data(i,:) = data(i,:)/sum(data(i,:));
    end

end

