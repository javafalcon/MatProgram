function [y,Count]=ReadData(path)
%���백��������(txt�ļ�)
%��ÿ�������ʵİ��������ж�Ӧ�洢�ڲ�ͬ�ı�����
%ͳ�Ƶ����ʵ�����
%
fid1=fopen(path,'rb');
[A,countA]=fread(fid1,inf,'char');
fclose(fid1);
j=1;i=1;
flag=0;
Seq_Amino='';           %Seq_AminoΪ���������д�ű���
while i~=countA
    if A(i)=='>'
        flag=1;
    end
    if A(i)==10 & flag==1
        i=i+1;
        while A(i)~='>'
            if A(i)~=13 & A(i)~=10 %13:�س���10������
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
