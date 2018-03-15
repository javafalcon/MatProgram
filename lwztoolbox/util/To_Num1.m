
function y=To_Num1(Origin_Sequence,Origin_Count)

for i=1:Origin_Count
    switch Origin_Sequence(i)
        case 'A' 
            Sequence_Number(i)=7.62;
        case 'C' 
            Sequence_Number(i)=10.93;
        case 'D'
            Sequence_Number(i)=6.18;
        case 'E'
            Sequence_Number(i)=6.38;
        case 'F'
            Sequence_Number(i)=8.99;
        case 'G'
            Sequence_Number(i)=7.31;
        case 'H'
            Sequence_Number(i)=7.85;
        case 'I'
            Sequence_Number(i)=9.99;
        case 'K'
            Sequence_Number(i)=5.72;
        case 'L'
            Sequence_Number(i)=9.37;
        case 'M'
            Sequence_Number(i)=9.83;
        case 'N'
            Sequence_Number(i)=6.17;
        case 'P'
            Sequence_Number(i)=6.64;
        case 'Q'
            Sequence_Number(i)=6.67;
        case 'R'
            Sequence_Number(i)=6.81;
        case 'S'
            Sequence_Number(i)=6.93;
        case 'T'
            Sequence_Number(i)=7.08;
        case 'V'
            Sequence_Number(i)=10.38;
        case 'W'
            Sequence_Number(i)=8.41;
        case 'Y'
            Sequence_Number(i)=8.53;
        case 'a' 
            Sequence_Number(i)=7.62;
        case 'c' 
            Sequence_Number(i)=10.93;
        case 'd'
            Sequence_Number(i)=6.18;
        case 'e'
            Sequence_Number(i)=6.38;
        case 'f'
            Sequence_Number(i)=8.99;
        case 'g'
            Sequence_Number(i)=7.31;
        case 'h'
            Sequence_Number(i)=7.85;
        case 'i'
            Sequence_Number(i)=9.99;
        case 'k'
            Sequence_Number(i)=5.72;
        case 'l'
            Sequence_Number(i)=9.37;
        case 'm'
            Sequence_Number(i)=9.83;
        case 'n'
            Sequence_Number(i)=6.17;
        case 'p'
            Sequence_Number(i)=6.64;
        case 'q'
            Sequence_Number(i)=9.99;
        case 'r'
            Sequence_Number(i)=6.81;
        case 's'
            Sequence_Number(i)=6.93;
        case 't'
            Sequence_Number(i)=9.99;
        case 'v'
            Sequence_Number(i)=10.38;
        case 'w'
            Sequence_Number(i)=8.41;
        case 'y'
            Sequence_Number(i)=8.53;
    end
end
y=Sequence_Number;