%Author:Lin Wei-Zhong
%Date:2008-2-11 
%Version:1.0
%GreyElement(fmat,AAGroup,Group_Count)
%函数功能：计算氨基酸成分向量组cell(1,type)型变量AAGroup的伪氨基酸成分，保存到文件fmat中
%fmat:保存伪氨基酸成分的文件
%AAGroup:氨基酸成分，cell(1,type)型变量
%Group_Count:每个类别的氨基酸数

function GM21Element(fmat,AAGroup,Group_Count)
type=length(Group_Count);
greyPse = cell(1,type);
for i=1:type
    greyPse{1,i}=cell(1,Group_Count(i));
    for j=1:Group_Count(i)
        y=To_Num2(AAGroup{i}{j},length(AAGroup{i}{j}));
        greyPse{1,i}{1,j}=GM21Param(y);
    end
end
save(fmat,'greyPse');