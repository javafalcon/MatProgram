clear;
clc;
load 7329sequences_pssm.mat;
N = 7329;
M = 4;
X=zeros(N,M);

for i = 1 : N
    i
  D = p{i};
  D=D(:,1:20);
  [row,col] = size(D);
  G = zeros(row,160);
  for r = 1 : row
      for c = 1 : col
           if D(r,c)<0
               D(r,c) = 256 + D(r,c);
           end
           G(r,(c-1)*8+1:c*8) = int8( dec2bin( D(r,c),8)) - 48;
      end
  end
   [ASM_E,CON_E,ENT_E,IDM_E] = GLCM_FEATURE(D);
    X(i,:)=[ASM_E CON_E ENT_E IDM_E];
   
  %X(i,:) = MomentsFeature(D,10);
  %X(i,:) = X(i,:)/norm(X(i,:));
end
[X,~]=mapminmax(X,0,1);
save 7329sequences_pssm_GLCMFeature_bin.mat X
% save 7329sequences_pssm_zernikeMoment.mat X