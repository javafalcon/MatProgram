%Author:Lin Wei-Zhong
%Date:2008-2-11 
%Version:1.0
%GreyElement(fmat,AAGroup,Group_Count)
%�������ܣ����㰱����ɷ�������cell(1,type)�ͱ���AAGroup��α������ɷ֣����浽�ļ�fmat��
%fmat:����α������ɷֵ��ļ�
%AAGroup:������ɷ֣�cell(1,type)�ͱ���
%Group_Count:ÿ�����İ�������

function GreyElement(fmat,AAGroup,Group_Count)
type=length(Group_Count);
greyPse = cell(1,type);
for i=1:type
    greyPse{1,i}=cell(1,Group_Count(i));
    for j=1:Group_Count(i)
        y=To_Num2(AAGroup{i}{j},length(AAGroup{i}{j}));
        greyPse{1,i}{1,j}=GMParam(y);
    end
end
save(fmat,'greyPse');