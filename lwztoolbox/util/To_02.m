function y=To_02(Origin_Sequence)
%输入参数为（1）原氨基酸序列（由20个英文字母组成的向量），
%          （2）该序列的长度（为整数）
%输出y为：由0、1字符组成的向量
bb='';
Sequence_01='';
Origin_Count=length(Origin_Sequence);

for i=1:Origin_Count
    switch Origin_Sequence(i)
        case 'A'
            bb='10001';
        case 'C'
            bb='11110';
        case 'D'
            bb='01001';
        case 'E'
            bb='01010';
        case 'F'
            bb='10111';
        case 'G'
            bb='10000';
        case 'H'
            bb='10010';
        case 'I'
            bb='11011';
        case 'K'
            bb='00110';
        case 'L'
            bb='11000';
        case 'M'
            bb='11010';
        case 'N'
            bb='01000';
        case 'P'
            bb='01011';
        case 'Q'
            bb='01100';
        case 'R'
            bb='01101'; 
        case 'S'
            bb='01110'; 
        case 'T'
            bb='01111';
        case 'V'
            bb='11100';
        case 'W'
            bb='10100';
        case 'Y'
            bb='10101'; 
        case 'a'
            bb='10001';
        case 'c'
            bb='11110';
        case 'd'
            bb='01001';
        case 'e'
            bb='01010';
        case 'f'
            bb='10111';
        case 'g'
            bb='10000';
        case 'h'
            bb='10010';
        case 'i'
            bb='11011';
        case 'k'
            bb='00110';
        case 'l'
            bb='11000';
        case 'm'
            bb='11010';
        case 'n'
            bb='01000';
        case 'p'
            bb='01011';
        case 'q'
            bb='01100';
        case 'r'
            bb='01101'; 
        case 's'
            bb='01110'; 
        case 't'
            bb='01111';
        case 'v'
            bb='11100';
        case 'w'
            bb='10100';
        case 'y'
            bb='10101'; 
            %otherwise
            %break
    end
    Sequence_01=[Sequence_01,bb];                         %Sequence_01是存放01的变量
end
y=Sequence_01;