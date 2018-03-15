function amino=To_Amino(x)
aminoNum=[7.62 10.93 6.18 6.38 8.99 7.31 7.85 9.99 5.72 9.37 9.83 6.17 6.64 6.67 6.81 6.93 7.08 10.38 8.41 8.53];
aminoVal=['A' 'C' 'D' 'E' 'F' 'G' 'H' 'I' 'k' 'L' 'M' 'N' 'P' 'Q' 'R' 'S' 'T' 'V' 'W' 'Y'];
r=abs(aminoNum-x);
m = min(r);
for i=1:20
    if r(i)==m
       amino = aminoVal(i);
       break;
    end
end
