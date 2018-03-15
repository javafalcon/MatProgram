clear
clc
% fid = fopen('list1.txt');
% tline = fgetl(fid);
% i = 1;
% while ischar(tline)
%     A = strsplit(tline);
%     prots(i).id = str2num(A{1});
%     k = 2;
%     go = struct();
%     while k < length(A)
%         B = strsplit(A{k},',');
%         go(k-1).index = str2num(B{1});
%         go(k-1).val = str2double(B{2});
%         k = k + 1;
%     end
%     prots(i).feature = go;
%     i = i + 1;
%     tline = fgetl(fid);
% end
% fclose(fid);
% save 7329sequenceGO.mat prots
load 7329sequenceGO.mat
load 7329sequencesFamily.mat
load 7329sequencesGrey21PSSM.mat

%% calculate the distance between proteins
% dist = zeros(7329,7329);
% for i = 1 : 7329
%     for j = 1 : 7329
%         if i==j
%             dist(i,j) = 0;
%         else
%             ilen = length(prots(i).feature);
%             jlen = length(prots(j).feature);
%             d = 0;
%             
%             if ilen > 1 && jlen > 1 %calculate distance by go features
%                 ik = 1; jk = 1;
%                 while ik <= ilen && jk <= jlen
%                     i_index = prots(i).feature(ik).index;
%                     j_index = prots(j).feature(jk).index;
%                     if i_index > j_index
%                         d = d + prots(j).feature(jk).val^2;
%                         jk = jk + 1;
%                     elseif i_index < j_index
%                             d = d + prots(i).feature(ik).val^2;
%                             ik = ik + 1;
%                     else
%                         d = d + (prots(i).feature(ik).val - prots(j).feature(jk).val).^2;
%                         ik = ik + 1; jk = jk + 1;
%                     end
%                 end
%                 while ik <= ilen  %i# protein has bigger go-id feature
%                      d = d + prots(i).feature(ik).val^2;
%                     ik = ik + 1;
%                 end
%                 while jk <= jlen %j# protein has bigger go-id feature
%                     d = d + prots(j).feature(jk).val^2;
%                     jk = jk + 1;
%                 end
%                 d = sqrt(d)/(ilen+jlen);
%             else %calculate distance by PSSM features
%                 d = (psepssm(i,:)-psepssm(j,:)).^2;
%                 d = sum(d);
%                 d = sqrt(d)/80;
%             end
%             dist(i,j) = d;
%         end
%     end
% end
% save distance.mat dist

%%
load distance.mat
Y = zeros(7329,1);
Auc50 = 0;
Auc1 = 0;
for i = 1 : 7329
    i
    ind = true(7329,1);
    ind(i) = false;
    trainX = psepssm(ind,:);%training dataset
    trainY = familyId(ind);
    
    testX = psepssm(i,:);%testing dataset
    testY = familyId{i};
    
    label_Y = strcmp(trainY,testY);
    r = dist(i,ind);
    
        
    
    Auc1 = Auc1 + AUCK(label_Y,r,1);
    Auc50 = Auc50 + AUCK(label_Y,r,50);
end
Auc50 = Auc50/7329;
Auc1 = Auc1/7329;
        