function H=Hydrophilicity(amino)
%The hydrophilicity value of amino acid according to the sequence "A C D E
%F G H I K L M N P Q R S T V W Y"
value = [-0.5 -1.0 3.0 3.0 -2.5 0.0 -0.5 -1.8 3.0 -1.8 -1.3 0.2 0.0 0.2 3.0 0.3 -0.4 -1.5 -3.4 -2.3];
HA = StandardConversion(value);
i = Amino2Index(amino);
H = HA(i);

