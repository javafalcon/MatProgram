%把氨基酸序列做成20维向量Vector_Group
function y = AAVector(Amino_Sequence)

countA = 0;countC = 0;countD = 0;countE = 0;countF = 0;
countG = 0;countH = 0;countI = 0;countK = 0;countL = 0;
countM = 0;countN = 0;countP = 0;countQ = 0;countR = 0;
countS = 0;countT = 0;countV = 0;countW = 0;countY = 0;
other = 0;
Sequence_Count = length(Amino_Sequence);
for k = 1:Sequence_Count
    switch Amino_Sequence(k)
        case 'A' 
            countA = countA + 1;
        case 'C' 
            countC = countC + 1;
        case 'D'
            countD = countD + 1;
        case 'E'
            countE = countE + 1;
        case 'F'
            countF = countF + 1;
        case 'G'
            countG = countG + 1;
        case 'H'
            countH = countH + 1;
        case 'I'
            countI = countI + 1;
        case 'K'
            countK = countK + 1;
        case 'L'
            countL = countL + 1;
        case 'M'
            countM = countM + 1;
        case 'N'
            countN = countN + 1;
        case 'P'
            countP = countP + 1;
        case 'Q'
            countQ = countQ + 1;
        case 'R'
            countR = countR + 1;
        case 'S'
            countS = countS + 1;
        case 'T'
            countT = countT + 1;
        case 'V'
            countV = countV + 1;
        case 'W'
            countW = countW + 1;
        case 'Y'
            countY = countY + 1;
        case 'a' 
            countA = countA + 1;
        case 'c' 
            countC = countC + 1;
        case 'd'
            countD = countD + 1;
        case 'e'
            countE = countE + 1;
        case 'f'
            countF = countF + 1;
        case 'g'
            countG = countG + 1;
        case 'h'
            countH = countH + 1;
        case 'i'
            countI = countI + 1;
        case 'k'
            countK = countK + 1;
        case 'l'
            countL = countL + 1;
        case 'm'
            countM = countM + 1;
        case 'n'
            countN = countN + 1;
        case 'p'
            countP = countP + 1;
        case 'q'
            countQ = countQ + 1;
        case 'r'
            countR = countR + 1;
        case 's'
            countS = countS + 1;
        case 't'
            countT = countT + 1;
        case 'v'
            countV = countV + 1;
        case 'w'
            countW = countW + 1;
        case 'y'
            countY = countY + 1;
         otherwise
             other = other + 1;
    end
end
a(1) = countA/Sequence_Count;
a(2) = countC/Sequence_Count;
a(3) = countD/Sequence_Count;
a(4) = countE/Sequence_Count;
a(5) = countF/Sequence_Count;
a(6) = countG/Sequence_Count;
a(7) = countH/Sequence_Count;
a(8) = countI/Sequence_Count;
a(9) = countK/Sequence_Count;
a(10) = countL/Sequence_Count;
a(11) = countM/Sequence_Count;
a(12) = countN/Sequence_Count;
a(13) = countP/Sequence_Count;
a(14) = countQ/Sequence_Count;
a(15) = countR/Sequence_Count;
a(16) = countS/Sequence_Count;
a(17) = countT/Sequence_Count;
a(18) = countV/Sequence_Count;
a(19) = countW/Sequence_Count;
a(20) = countY/Sequence_Count;
Vector = [];
for i = 1:20
    Vector = [Vector;a(i)];                    %first 20 dimension of Vector_Group
end
y = Vector;

