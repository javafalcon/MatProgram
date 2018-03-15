%av: the value of amino acids "A C D E F G H I K L M N P Q R S T V W Y"
function v=StandardConversion(vec)
m1 = mean(vec);
t = (vec-m1).^2;
m2 = sqrt( sum( t)/20);
v = (vec-m1)./m2;
