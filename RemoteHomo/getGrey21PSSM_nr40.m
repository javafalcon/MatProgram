% load 7329sequencesGrey21PSSM.mat
% load 7329sequences_pssm_momentsFeature.mat
load 7329sequences_pssm_GLCMFeature.mat
psepssm=X;
[N1, M] = size(psepssm);

load 7329sequencesFamily.mat
seqId1 = seqId;
 
load 7329sequencesFamily_nr40.mat
seqId2 = seqId;
N2 = length(seqId2);

data = zeros(N2,M);

for i = 1 : N2
    k = findStrFromCell(seqId1,seqId2{i});
    data(i,:) = psepssm(k,:);
end
% save 7329sequences_pssm_momentsFeature_nr40.mat data
save 7329sequences_pssm_GLCMFeature_nr40.mat data