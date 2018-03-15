%----------------------调用子程序-------------------------%
%---:methodxx(sequence_01)
%---:TO_GLCM(Amino_to_CAI)
%---:GLCM_FEATURE(GLCM)
%--------------------------------------------------------%
%首先生成每个氨基酸序列对应的CAI图，再求出其GLCM，然后求二次统计特征
function Save_GLCM_Element(fmat,Sgn01_Group, Group_Count)
CAI_Dimention = 100;
type = length(Group_Count);
for i = 1:type
    for j = 1:Group_Count(i)
        Temp_01 = Sgn01_Group{i}{j};
        Amino_to_CAI = '';
        for ii = 1:CAI_Dimention
            Amino_to_CAI = [Amino_to_CAI;Temp_01];     %Amino_to_CAI 为多维01字符矩阵
            Temp_01 = method84(Temp_01);
        end
        %[n,p] = size(Amino_to_CAI); 
        %Amino_to_CAI(:,2:2:p) = [];                      %压缩列
        %[n,p] = size(Amino_to_CAI); 
        %Amino_to_CAI(2:2:n,:) = [];                      %压缩行
        [GLCM_E,GLCM_N] = TO_GLCM(Amino_to_CAI);                  %生成水平和垂直GLCM
        [GLCM_Group{i}{j}(1),GLCM_Group{i}{j}(2),GLCM_Group{i}{j}(3),GLCM_Group{i}{j}(4)] = GLCM_FEATURE(GLCM_E);           %求出灰度共生矩阵的二次统计特征
        clear Amino_to_CAI
    end
end
save(fmat,'GLCM_Group');
