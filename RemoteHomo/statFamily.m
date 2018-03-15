clear
clc
% load 7329sequencesFamily_nr40.mat
% load 7329sequencesFamily.mat
load 3187sequencesFamily.mat
M = length(familyId);
Y = ones(M,1);
t = 1;
superY = ones(M,1);
supert = 1;
for i = 2 : M
  if strcmp(familyId{i},familyId{i-1})
      Y(i)=t;
  else
      t = t+1;
      Y(i)=t;
  end
  if strcmp(familyId{i}(1:end-2),familyId{i-1}(1:end-2))
      superY(i)=supert;
  else
      supert = supert + 1;
      superY(i) = supert;
  end
end

I = true(M,1);
for i = 2 : M-1
    if Y(i)~=Y(i-1) & Y(i) ~= Y(i+1)
        I(i)=false;
    end
end
if Y(M) ~= Y(M-1)
    I(M)=false;
end