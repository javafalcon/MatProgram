function writeWekaDataset(data,group,arffFilename)
% writeWekaDataset read samples vector and labels, than write into files
% of arff and xml which are used in weka program
% data: M-N matrix, the i-th sample is expressed by i-th row vector
% classname: a string cell, the name of classes, numeric or string
% group:M*1 columns vector, the i-th sample's labels is expressed by i-th
%           row element

[row,attr_col] = size(data);

fid_arff = fopen(arffFilename,'w');
fprintf(fid_arff, '%s\n\n', '@relation relationship');
for i = 1 : attr_col
    fprintf(fid_arff, '@attribute Att%d numeric\n', i);
end

fprintf(fid_arff, '@attribute class {0,1}\n');

fprintf(fid_arff, '\n');
fprintf(fid_arff, '@data\n');

for i = 1 : row
    for j = 1 : attr_col
        fprintf(fid_arff, '%f,', data(i,j));
    end
    
    fprintf(fid_arff, '%d\n', group(i));
        
end
fclose(fid_arff);