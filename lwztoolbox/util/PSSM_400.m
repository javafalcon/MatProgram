%return 400-dimensions vector
%pssm is the position specific scoring matrix correspond to seq
function v = PSSM_400(seq,pssm)
% aa = [A  R  N  D  C  Q  E  G  H  I  L  K  M  F  P  S  T  W  Y  V];
aa='ARNDCQEGHILKMFPSTWYV';
v=zeros(1,400);
for i = 1 : 20
  v(20*(i-1)+1:20*i) = sum( pssm(seq==aa(i)));
end
v = v/length(seq);
v = 1./(1+exp(-v));

    