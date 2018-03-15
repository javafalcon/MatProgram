%N: Amount of SMOTE N%
%k: Number of nearest neighbors k
%t: degree of imbalance. Integer more than 1

function [ syndata, synlabels ] = GreySmote( data, labels, N, k, threshold )
% Disused

    syndata = data;
    synlabels = labels;
    
    [Rows,Cols] = size(syndata);
    lm=size(synlabels,2);
    lv = sum(synlabels,1);
    [M1,I1] = max(lv);%largest label
    [M22,I2] = min(lv);%samllest label
    mul = round(M1/M22);
    
    while mul > N
        %synthesis new element
        %Each elements of smallest class are synthesized N new elements 
%         syndata = zeros(Rows+M2*(N-1),Cols);
%         synlabels = zeros(Rows+M2*(N-1),lm);
%         syndata(1:Rows,:) = data;
%         synlabels(1:Rows,:) = labels;
        M2 = sum(labels(:,I2)==1);
        minclassindex = (labels(:,I2)==1);
        minclassdata = data(minclassindex,:);
        minclasslabels = labels(minclassindex,:);
        
        
%         p = Rows+1;
        disp(['largest family is ' int2str(I1) ' have ' int2str(M1)]);
        disp(['samlest family is ' int2str(I2) ' have ' int2str(M22)]);
        disp(['M1/M2=' num2str(M1/M22)]);
        disp(' ');
        k = min(k,M2-1);
        for i = 1 : M2
            %Compute k nearest neighbors for i,
            d = dist(minclassdata, minclassdata(i,:)');
            [mindist,minInd] = sort(d);
            %and save the indices in the nnarray
            nnarray=zeros(k,1);
            a = 1; j = 1;
            while a <= k
                if minInd(j) ~= i
                    nnarray(a) = minInd(j);
                    a = a + 1;
                end
                j = j + 1;
            end
            Populate(N,i,nnarray);
        end
%         data = syndata;
%         labels = synlabels;
        
%         Rows = size(syndata,1);
        lv = sum(synlabels,1);
        [M1,I1] = max(lv);%largest label
        [M22,I2] = min(lv);%samllest label
        mul = round(M1/M22);
    end
    
    function Populate(Mt,i,nnarray)
        while Mt > 0 
            %Choose a random numbers between 1 and k, call it nn.
            %This step choose one of the k-nearest neighbors of i.
            nn = randi(k,1);  
            newvect = zeros(1,Cols);
            for attr = 1 : Cols
                dif = minclassdata(nnarray(nn),attr) - minclassdata(i,attr);
                gap = rand;%random number between o and 1
%                 syndata(p,attr) = minclassdata(i,attr)+gap*dif;
                newvect(attr) = minclassdata(i,attr) + gap*dif;
            end
          
            newlabel = zeros(1,lm);
            newlabel(I2) = 1;
%             synlabels(p,:) = zeros(1,lm);
%             synlabels(p,I2) = 1;
            
            for labelattr = 1 : lm
                if labelattr ~= I2 && minclasslabels(i,labelattr)==1
                    %subfamily index
                    subind = (labels(:,labelattr)==1);
%                     degree = GreyIncidenceDegree(syndata(p,:),data(subind,:));
                    degree = GreyIncidenceDegree(newvect,data(subind,:));
                    if max(degree) > threshold
%                         synlabels(p,labelattr) = 1;
                          newlabel(labelattr) = 1;
                    end
                end
            end
            
%             p = p + 1; 
            Mt = Mt - 1;
            syndata = [syndata; newvect];
            synlabels = [synlabels; newlabel];
        end
    end
end
        


