
function y=To_Num3(Origin_Sequence,Origin_Count)

for i=1:Origin_Count
    switch Origin_Sequence(i)
        case 'A' 
            Sequence_Number(i)=10;
        case 'C' 
            Sequence_Number(i)=20;
        case 'D'
            Sequence_Number(i)=30;
        case 'E'
            Sequence_Number(i)=40;
        case 'F'
            Sequence_Number(i)=50;
        case 'G'
            Sequence_Number(i)=60;
        case 'H'
            Sequence_Number(i)=70;
        case 'I'
            Sequence_Number(i)=80;
        case 'K'
            Sequence_Number(i)=90;
        case 'L'
            Sequence_Number(i)=100;
        case 'M'
            Sequence_Number(i)=110;
        case 'N'
            Sequence_Number(i)=120;
        case 'P'
            Sequence_Number(i)=130;
        case 'Q'
            Sequence_Number(i)=140;
        case 'R'
            Sequence_Number(i)=150;
        case 'S'
            Sequence_Number(i)=160;
        case 'T'
            Sequence_Number(i)=170;
        case 'V'
            Sequence_Number(i)=180;
        case 'W'
            Sequence_Number(i)=190;
        case 'Y'
            Sequence_Number(i)=200;
        case 'a' 
            Sequence_Number(i)=10;
        case 'c' 
            Sequence_Number(i)=20;
        case 'd'
            Sequence_Number(i)=30;
        case 'e'
            Sequence_Number(i)=40;
        case 'f'
            Sequence_Number(i)=50;
        case 'g'
            Sequence_Number(i)=60;
        case 'h'
            Sequence_Number(i)=70;
        case 'i'
            Sequence_Number(i)=80;
        case 'k'
            Sequence_Number(i)=90;
        case 'l'
            Sequence_Number(i)=100;
        case 'm'
            Sequence_Number(i)=110;
        case 'n'
            Sequence_Number(i)=120;
        case 'p'
            Sequence_Number(i)=130;
        case 'q'
            Sequence_Number(i)=140;
        case 'r'
            Sequence_Number(i)=150;
        case 's'
            Sequence_Number(i)=160;
        case 't'
            Sequence_Number(i)=170;
        case 'v'
            Sequence_Number(i)=180;
        case 'w'
            Sequence_Number(i)=190;
        case 'y'
            Sequence_Number(i)=200;
    end
end
y=Sequence_Number;