function vec = AAEntroyFeature( sequence )
%
%Input:
%   sequence    -amino acids

%Output
%   vec         -a column vector with 4 elements


len = length( sequence);

y = AAVector( sequence);
%Computing Amino Acid class entroy
aa = zeros(1,6);

for i = 1 : len
    switch sequence(i)
        case {'G','A','V','L','I'}
            aa(1) = aa(1) + 1;
        case {'S', 'C', 'T', 'M'}
            aa(2) = aa(2) + 1;
        case {'P'}
            aa(3) = aa(3) + 1;
        case {'F', 'Y', 'W'}
            aa(4) = aa(4) + 1;
        case {'H','K','R'}
            aa(5) = aa(5) + 1;
        case {'D','E','N','Q'}
            aa(6) = aa(6) + 1;
    end
end
aaEntroy = 0;
for i = 1 : 6
    if aa(i) == 0
        e = 0;
    else
        e = aa(i)/len * log2( aa(i)/len);
    end
    aaEntroy = aaEntroy - e;
end

%Computing hydrophobicity entroy
h1 = 0;%hydrophobic
h2 = 0;%hydrophilc
for i = 1 : len
    switch sequence(i) 
        case {'A','C','F','G','I','L','M','P','V','W','Y'}
            h1 = h1 + 1;
        case {'D','E','H','K','N','Q','R','S','T'}
            h2 = h2 + 1;
    end
end

if h1 == 0
    e1 = 0;
else
    e1 = h1/len * log2( h1/len);
end

if h2 == 0
    e2 =0;
else
    e2 = h2/len * log2( h2/len);
end
    
hyEntroy = -( e1 + e2);

%Computing polarity entroy
p = zeros(1,4);%nonplolar, basic polar, polar, acidic polar
for i = 1 : len
    switch sequence(i)
        case {'A','C','G','I','L','M','F','P','W','V'}
            p(1) = p(1) + 1;
        case {'R','H','K'}
            p(2) = p(2) + 1;
        case {'N','Q','S','T','Y'}
            p(3) = p(3) + 1;
        case {'D','E'}
            p(4) = p(4) + 1;
    end
end

plEntroy = 0;
for j = 1 : 4
    if p(j) == 0
        e = 0;
    else
        e = p(j)/len * log2( p(j)/len);
    end
    plEntroy = plEntroy - e;
end

%Computing charge entroy
c = zeros(1,3);%neutrial,positive,negative
for i = 1 : len
    switch sequence(i)
        case {'A','N','C','Q','G','I','L','M','F','P','S','T','W','Y','V'}
            c(1) = c(1) + 1;
        case {'R','K'}
            c(2) = c(2) + 1;
        case {'D','E'}
            c(3) = c(3) + 1;
        case {'H'}
            c(1) = c(1) + 0.9;
            c(2) = c(2) + 0.1;
    end
end

chEntroy = 0;
for j = 1 : 3
    if c(j) == 0
        e = 0;
    else
        e = c(j)/len * log2( c(j)/len);
    end
    chEntroy = chEntroy-e;
end

%average three entroy
% entr = (aaEntroy + hyEntroy + plEntroy + chEntroy);
% aaEntroy = aaEntroy/entr;
% hyEntroy = hyEntroy/entr;
% plEntroy = plEntroy/entr;
% chEntroy = chEntroy/entr;

vec = [y; aaEntroy;hyEntroy; plEntroy; chEntroy];

end

