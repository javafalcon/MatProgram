
function y=To_Num(Origin_Sequence,Origin_Count)

for i=1:Origin_Count
    switch Origin_Sequence(i)
        case 'A' 
            Sequence_Number(i)=25;
        case 'C' 
            Sequence_Number(i)=15;
        case 'D'
            Sequence_Number(i)=28;
        case 'E'
            Sequence_Number(i)=29;
        case 'F'
            Sequence_Number(i)=11;
        case 'G'
            Sequence_Number(i)=30;
        case 'H'
            Sequence_Number(i)=5;
        case 'I'
            Sequence_Number(i)=18;
        case 'K'
            Sequence_Number(i)=20;
        case 'L'
            Sequence_Number(i)=3;
        case 'M'
            Sequence_Number(i)=19;
        case 'N'
            Sequence_Number(i)=21;
        case 'P'
            Sequence_Number(i)=1;
        case 'Q'
            Sequence_Number(i)=4;
        case 'R'
            Sequence_Number(i)=6;
        case 'S'
            Sequence_Number(i)=9;
        case 'T'
            Sequence_Number(i)=16;
        case 'V'
            Sequence_Number(i)=26;
        case 'W'
            Sequence_Number(i)=14;
        case 'Y'
            Sequence_Number(i)=12;
        case 'a' 
            Sequence_Number(i)=25;
        case 'c' 
            Sequence_Number(i)=15;
        case 'd'
            Sequence_Number(i)=28;
        case 'e'
            Sequence_Number(i)=29;
        case 'f'
            Sequence_Number(i)=11;
        case 'g'
            Sequence_Number(i)=30;
        case 'h'
            Sequence_Number(i)=5;
        case 'i'
            Sequence_Number(i)=18;
        case 'k'
            Sequence_Number(i)=20;
        case 'l'
            Sequence_Number(i)=3;
        case 'm'
            Sequence_Number(i)=19;
        case 'n'
            Sequence_Number(i)=21;
        case 'p'
            Sequence_Number(i)=1;
        case 'q'
            Sequence_Number(i)=4;
        case 'r'
            Sequence_Number(i)=6;
        case 's'
            Sequence_Number(i)=9;
        case 't'
            Sequence_Number(i)=16;
        case 'v'
            Sequence_Number(i)=26;
        case 'w'
            Sequence_Number(i)=14;
        case 'y'
            Sequence_Number(i)=12;
    end
end
y=Sequence_Number;