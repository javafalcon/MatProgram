function y=To_01(Origin_Sequence)
%输入参数为（1）原氨基酸序列（由20个英文字母组成的向量），
%          （2）该序列的长度（为整数）
%输出y为：由0、1字符组成的向量
bb='';
Sequence_01='';
Origin_Count=length(Origin_Sequence);

for i=1:Origin_Count
    switch Origin_Sequence(i)
        case 'A'
            bb='11001';
        case 'C'
            bb='01111';
        case 'D'
            bb='11100';
        case 'E'
            bb='11101';
        case 'F'
            bb='01011';
        case 'G'
            bb='11110';
        case 'H'
            bb='00101';
        case 'I'
            bb='10010';
        case 'K'
            bb='10100';
        case 'L'
            bb='00011';
        case 'M'
            bb='10011';
        case 'N'
            bb='10101';
        case 'P'
            bb='00001';
        case 'Q'
            bb='00100';
        case 'R'
            bb='00110'; 
        case 'S'
            bb='01001'; 
        case 'T'
            bb='10000';
        case 'V'
            bb='11010';
        case 'W'
            bb='01110';
        case 'Y'
            bb='01100'; 
        case 'a'
            bb='11001';
        case 'c'
            bb='01111';
        case 'd'
            bb='11100';
        case 'e'
            bb='11101';
        case 'f'
            bb='01011';
        case 'g'
            bb='11110';
        case 'h'
            bb='00101';
        case 'i'
            bb='10010';
        case 'k'
            bb='10100';
        case 'l'
            bb='00011';
        case 'm'
            bb='10011';
        case 'n'
            bb='10101';
        case 'p'
            bb='00001';
        case 'q'
            bb='00100';
        case 'r'
            bb='00110'; 
        case 's'
            bb='01001'; 
        case 't'
            bb='10000';
        case 'v'
            bb='11010';
        case 'w'
            bb='01110';
        case 'y'
            bb='01100'; 
            %otherwise
            %break
    end
    Sequence_01=[Sequence_01,bb];                         %Sequence_01是存放01的变量
end
y=Sequence_01;