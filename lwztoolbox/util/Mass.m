function M=Mass(amino)
%The mass value of amino acid according to the sequence "A C D E
%F G H I K L M N P Q R S T V W Y"
value=[15.0 47.0 59.0 73.0 91.0 1.0 82.0 57.0 73.0 57.0 75.0 58.0 42.0 72.0 101.0 31.0 45.0 43.0 130.0 107.0];
MA = StandardConversion(value);
i = Amino2Index(amino);
M = MA(i);
