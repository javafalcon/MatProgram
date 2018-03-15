
function y=To_Num2(Origin_Sequence,Origin_Count)
Sequence_Number=zeros(1,Origin_Count);
for i=1:Origin_Count
    switch Origin_Sequence(i)
        case 'A' 
            Sequence_Number(i)=17;
        case 'C' 
            Sequence_Number(i)=30;
        case 'D'
            Sequence_Number(i)=9;
        case 'E'
            Sequence_Number(i)=10;
        case 'F'
            Sequence_Number(i)=23;
        case 'G'
            Sequence_Number(i)=16;
        case 'H'
            Sequence_Number(i)=18;
        case 'I'
            Sequence_Number(i)=27;
        case 'K'
            Sequence_Number(i)=6;
        case 'L'
            Sequence_Number(i)=24;
        case 'M'
            Sequence_Number(i)=26;
        case 'N'
            Sequence_Number(i)=8;
        case 'P'
            Sequence_Number(i)=11;
        case 'Q'
            Sequence_Number(i)=12;
        case 'R'
            Sequence_Number(i)=13;
        case 'S'
            Sequence_Number(i)=14;
        case 'T'
            Sequence_Number(i)=15;
        case 'V'
            Sequence_Number(i)=28;
        case 'W'
            Sequence_Number(i)=20;
        case 'Y'
            Sequence_Number(i)=21;
        case 'a' 
            Sequence_Number(i)=17;
        case 'c' 
            Sequence_Number(i)=30;
        case 'd'
            Sequence_Number(i)=9;
        case 'e'
            Sequence_Number(i)=10;
        case 'f'
            Sequence_Number(i)=23;
        case 'g'
            Sequence_Number(i)=16;
        case 'h'
            Sequence_Number(i)=18;
        case 'i'
            Sequence_Number(i)=27;
        case 'k'
            Sequence_Number(i)=6;
        case 'l'
            Sequence_Number(i)=24;
        case 'm'
            Sequence_Number(i)=26;
        case 'n'
            Sequence_Number(i)=8;
        case 'p'
            Sequence_Number(i)=11;
        case 'q'
            Sequence_Number(i)=12;
        case 'r'
            Sequence_Number(i)=13;
        case 's'
            Sequence_Number(i)=14;
        case 't'
            Sequence_Number(i)=15;
        case 'v'
            Sequence_Number(i)=28;
        case 'w'
            Sequence_Number(i)=20;
        case 'y'
            Sequence_Number(i)=21;
    end
end
y=Sequence_Number;