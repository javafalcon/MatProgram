%To compute the distance between x and y
function d = MinkowskiDistance(x,y,p)
z = abs(x - y);
z = z.^p;
d = sum(z)^(1/p);