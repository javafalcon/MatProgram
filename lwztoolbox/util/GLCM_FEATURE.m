function [ASM_E,CON_E,ENT_E,IDM_E] = GLCM_FEATURE(A)
% 求灰度共生矩阵A、B的二阶统计特征,A、B分别为水平和垂直GLCM（这里的GLCM未进行标准化）
% ASM(角二次矩),CON(对比度),COR(相关),ENT(熵),IDM(逆差矩)

% 2007年5月18号编
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%-----------------------水平GLCM特征量-----------------------%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[n,p] = size(A);
% 求角二次矩 ASM
ASM_E = sum(sum(A.^2));
% 求对比度 CON
CON_E = 0;
ENT_E = 0;
IDM_E = 0;
for i = 1:n
    for j = 1:p
        CON_E = CON_E + A(i,j)*(i-j)^2;
        if A(i,j) ~= 0
            ENT_E = ENT_E + A(i,j)*log(A(i,j));
        end
        IDM_E = IDM_E+A(i,j)/(1+(i-j)^2);
    end
end

