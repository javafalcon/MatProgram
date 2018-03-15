function [y,Count]=ReadData(path)
%读入氨基酸序列(txt文件)
%把每个蛋白质的氨基酸序列对应存储在不同的变量中
%统计蛋白质的数量
%
fid1=fopen(path,'rb');
[A,countA]=fread(fid1,inf,'char');
fclose(fid1);
j=1;i=1;
flag=0;
Seq_Amino='';           %Seq_Amino为氨基酸序列存放变量
while i~=countA
    if A(i)=='>'
        flag=1;
    end
    if A(i)==10 & flag==1
        i=i+1;
        while A(i)~='>'
            if A(i)~=13 & A(i)~=10 %13:回车；10：换行
                Seq_Amino=[Seq_Amino,A(i)];
            end   
            i=i+1;
        end
        X{j}=Seq_Amino;
        Seq_Amino='';
        j=j+1;
        i=i-1;
        flag=0;
    end    
    i=i+1;
end
Count=j-1;
y=X;
