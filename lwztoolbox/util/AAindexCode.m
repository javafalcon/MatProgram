function num=AAindexCode(amino_acid,index,type)
% amino_acid  -A letter express amino acid
% index       -'Molecular Weight','Molecular Weight','Hydrophobicity-JACS',
%              'pK1','pK2','PI','ionic strength','WIMW960101','WEBA780101'
% type		  -If type=1, standardize the output
if nargin < 3
	type = 0;
end

text='ARNDCQEGHILKMFPSTWYV';
switch index
	case 'Molecular Weight'
		val = [89.09 174.20 132.12 133.10 121.15 146.15 147.13 75.07 155.16 131.17 ...
			   131.17 146.19 149.21 165.19 115.13 105.09 119.12 204.24 181.19 117.15];
	case 'Hydrophobicity'
		val = [0.87 0.85 0.09 0.66 1.52 0 0.67 0.1 0.87 3.15 ...
		       2.17 1.64 1.67 2.87 2.77 0.07 0.07 3.77 2.67 1.87];
	case 'Hydrophobicity-JACS'
		val = [0.62 -2.53 -0.78 -0.90 0.29 -0.85 -0.74 0.48 -0.40 1.38 ...
				1.06 -1.50 0.64 1.19 0.12 -0.18 -0.05 0.81 0.26 1.08];
	case 'pK1'
		val = [2.35 2.18 2.18 1.88 1.71 2.17 2.19 2.34 1.78 2.32 ...
				2.36 2.20 2.28 2.58 1.99 2.21 2.15 2.38 2.20 2.29];
	case 'pK2'
		val = [9.87 9.09 9.09 9.60 10.78 9.13 9.67 9.60 8.97 9.76 ...
				9.60 8.90 9.21 9.24 10.60 9.15 9.12 9.39 9.11 9.74];
	case 'PI'
		val = [6.11 10.76 10.76 2.98 5.02 5.65 3.08 6.06 7.64 6.04 ...
				6.04 9.47 5.74 5.91 6.30 5.68 5.60 5.88 5.63 6.02];
    case 'ionic strength'
        val = [-0.152 -0.089 -0.203 -0.355 0 -0.181 -0.411 -0.190 0 -0.086 ...
               -0.102 -0.062 -0.107 0.001 -0.181 -0.203 -0.170 0.275 0 -0.125];
    case 'WIMW960101' %Free energies of transfer of AcWl-X-LL peptides
        val = [4.08 3.91 3.83 3.02 4.49 3.67 2.23 4.24 4.08 4.52 ...
               4.81 3.77 4.48 5.38 3.80 4.12 4.11 6.10 5.19 4.18];
    case 'WEBA780101' %RF value in hig salt chromatography
        val = [0.89 0.88 0.89 0.87 0.85 0.82 0.84 0.92 0.83 0.76 ...
               0.73 0.97 0.74 0.52 0.82 0.96 0.92 0.20 0.49 0.85];
	otherwise
		error('incorrect type: %s', index)
end

if type == 1
	val = (val - mean(val))/std(val);
end

pos=strfind(text,upper(amino_acid));
if isempty(pos) == 0 
    num=val(pos);
else
	error('incorrect amino acid %s', amino_acid);
end
	