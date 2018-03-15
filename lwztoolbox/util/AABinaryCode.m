function c=AABinaryCode(aa)
c=zeros(1,5);
switch aa
    case 'P'
        c=[0 0 0 0 1];
    case 'Q'
        c=[0 0 1 0 0];
    case 'R'
        c=[0 0 1 1 0];
    case 'Y'
        c=[0 1 1 0 0];
    case 'W'
        c=[0 1 1 1 0];
    case 'T'
        c=[1 0 0 0 0];
    case 'M'
        c=[1 0 0 1 1];
    case 'N'
        c=[1 0 1 0 1];
    case 'V'
        c=[1 1 0 1 0];
    case 'E'
        c=[1 1 1 0 1];
    case 'L'
        c=[0 0 0 1 1];
    case 'H'
        c=[0 0 1 0 1];
    case 'S'
        c=[0 1 0 0 1];
    case 'F'
        c=[0 1 0 1 1];
    case 'C'
        c=[0 1 1 1 1];
    case 'I'
        c=[1 0 0 1 0];
    case 'K'
        c=[1 0 1 0 0];
    case 'A'
        c=[1 1 0 0 1];
    case 'D'
        c=[1 1 1 0 0];
    case 'G'
        c=[1 1 1 1 0];
end

