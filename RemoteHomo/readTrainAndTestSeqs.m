clear;
clc;

[headers, sequences] = fastaread('AllFamilySeqs.fasta');
warnState = warning; %Save the current warning state
warning('off','Bioinfo:fastawrite:AppendToFile'); 
fid = fopen('Supp-S3.txt');
i = 1;
flag = 0;
fileName = ['Family-' num2str(i)];
tline = fgetl(fid);
while( ~feof(fid) && ischar(tline))
    if ~isempty(tline)
        if( startsWith(tline, fileName))
            file_positive = [fileName '_P.fasta'];
            file_negative = [fileName '_N.fasta'];
            i = i + 1;
            fileName = ['Family-' num2str(i)];
        else
            if startsWith(tline, 'Positive')
                flag = 1;
            else
                if( startsWith(tline, 'Negative'))
                    flag = 0;
                else
                    C = strsplit(tline);
                    for seqid = C
                        k = findStringInCell(headers,seqid);
                        if flag == 1
                            fastawrite(file_positive, headers{k}, sequences{k});
                        else
                            fastawrite(file_negative, headers{k}, sequences{k});
                        end
                    end
                end
            end
        end
    end
    tline = fgetl(fid);
    tline = strtrim(tline);
end
warning(warnState); %Reset warning state to previous settings

                    
    
