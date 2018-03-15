function i = Amino2Index(amino)
switch amino
    case 'A'
        i=1;
    case 'C'
        i=2;
    case 'D'
        i=3;
    case 'E'
        i=4;
    case 'F'
        i=5;
    case 'G'
        i=6;
    case 'H'
        i=7;
    case 'I'
        i=8;
    case 'K'
        i=9;
    case 'L'
        i=10;
    case 'M'
        i=11;
    case 'N'
        i=12;
    case 'P'
        i=13;
    case 'Q'
        i=14;
    case 'R'
        i=15; 
    case 'S'
        i=16; 
    case 'T'
        i=17;
    case 'V'
        i=18;
    case 'W'
        i=19;
    case 'Y'
        i=20; 
    case 'a'
        i=1;
    case 'c'
        i=2;
    case 'd'
        i=3;
    case 'e'
        i=4;
    case 'f'
        i=5;
    case 'g'
        i=6;
    case 'h'
        i=7;
    case 'i'
        i=8;
    case 'k'
        i=9;
    case 'l'
        i=10;
    case 'm'
        i=11;
    case 'n'
        i=12;
    case 'p'
        i=13;
    case 'q'
        i=14;
    case 'r'
        i=15; 
    case 's'
        i=16; 
    case 't'
        i=17;
    case 'v'
        i=18;
    case 'w'
        i=19;
    case 'y'
        i=20; 
    otherwise
        disp([amino ' is not a valid amino acid']);
        i=0;
end