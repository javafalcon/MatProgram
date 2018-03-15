function writeMulanDataset(data,group,arffFilename,xmlFilename)
% writeMulanDataset read samples vector and labels, than write into files
% of arff and xml which are used in Mulan program
% data: M-N matrix, the i-th sample is expressed by i-th row vector
% group:M-Q matrix, the i-th sample's labels is expressed by i-th row vector

[~,attr_col] = size(data);
[row,label_col] = size(group);

fid_xml = fopen(xmlFilename, 'w');
fprintf(fid_xml, '<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\" ?>\n');
fprintf(fid_xml, '<labels xmlns=\"http://mulan.sourceforge.net/labels\">\n');
for i = 1 : label_col
    fprintf(fid_xml, '<label name=\"Label%d\"></label>\n',i);
end
fprintf(fid_xml, '</labels>');
fclose(fid_xml);

fid_arff = fopen(arffFilename,'w');
fprintf(fid_arff, '%s\n\n', '@relation relationship');
for i = 1 : attr_col
    fprintf(fid_arff, '@attribute Att%d numeric\n', i);
end
for i = 1 : label_col
    fprintf(fid_arff, '@attribute Label%d {0,1}\n', i);
end
fprintf(fid_arff, '\n');
fprintf(fid_arff, '@data\n');
for i = 1 : row
    %data(i,:) = data(i,:)/sum(data(i,:));
    for j = 1 : attr_col
        fprintf(fid_arff, '%f,', data(i,j));
    end
    for k = 1 : label_col
        if k == label_col
            fprintf(fid_arff, '%d\n', group(i,k));
        else
            fprintf(fid_arff, '%d,',group(i,k));
        end
    end
end
fclose(fid_arff);