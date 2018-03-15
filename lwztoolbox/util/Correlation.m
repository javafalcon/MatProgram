%calculate the correlation factor of amino "x" and amino "y"
function c = Correlation(x,y)
c1 = (Hydrophilicity(x) - Hydrophilicity(y))^2;
c2 = (Hydrophobicity(x) - Hydrophobicity(y))^2;
c3 = (Mass(x) - Mass(y))^2;
c = (c1 + c2 + c3)/3;