function H=Hydrophobicity(amino)
%The hydrophobicity value of amino acid according to the sequence "A C D E
%F G H I K L M N P Q R S T V W Y"
value=[0.62 0.29 -0.90 -0.74 1.19 0.48 -0.40 1.38 -1.50 1.06 0.64 -0.78 0.12 -0.85 -2.53 -0.18 -0.05 1.08 0.81 0.26];
HA = StandardConversion(value);
i = Amino2Index(amino);
H = HA(i);
