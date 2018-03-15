%----------------------�����ӳ���-------------------------%
%---:methodxx(sequence_01)
%---:TO_GLCM(Amino_to_CAI)
%---:GLCM_FEATURE(GLCM)
%--------------------------------------------------------%
%��������ÿ�����������ж�Ӧ��CAIͼ���������GLCM��Ȼ�������ͳ������
function Save_GLCM_Element(fmat,Sgn01_Group, Group_Count)
CAI_Dimention = 100;
type = length(Group_Count);
for i = 1:type
    for j = 1:Group_Count(i)
        Temp_01 = Sgn01_Group{i}{j};
        Amino_to_CAI = '';
        for ii = 1:CAI_Dimention
            Amino_to_CAI = [Amino_to_CAI;Temp_01];     %Amino_to_CAI Ϊ��ά01�ַ�����
            Temp_01 = method84(Temp_01);
        end
        %[n,p] = size(Amino_to_CAI); 
        %Amino_to_CAI(:,2:2:p) = [];                      %ѹ����
        %[n,p] = size(Amino_to_CAI); 
        %Amino_to_CAI(2:2:n,:) = [];                      %ѹ����
        [GLCM_E,GLCM_N] = TO_GLCM(Amino_to_CAI);                  %����ˮƽ�ʹ�ֱGLCM
        [GLCM_Group{i}{j}(1),GLCM_Group{i}{j}(2),GLCM_Group{i}{j}(3),GLCM_Group{i}{j}(4)] = GLCM_FEATURE(GLCM_E);           %����Ҷȹ�������Ķ���ͳ������
        clear Amino_to_CAI
    end
end
save(fmat,'GLCM_Group');
