%data: matrix with N rows, each row express a sample
%labels: matrix with N rows and M colums. 
%Y_pred: the labels predicted is a matrix with N rows and M colums
%k: k-nearest neightbor; d: the degree of imbalance;
function Y_pred =  OVMMLSVMPred_jk(data, labels, k, d, g)
if nargin < 5
    g = 1;
end
[N,M] = size(labels);
Y_pred = zeros(N,M);%Predicted label

for i = 1 : N
    indices = false(N,1);
    indices(i) = true;
    Dts = data(indices,:);%Testing data
    Dtr = data(~indices,:);%Training data
    groups = labels(~indices,:);%Training data's labels
    
    for j = 1 : M
        disp([int2str(i) '-' int2str(j)]);
        posInd = (groups(:,j) == 1); 
        posDtr = Dtr(posInd,:);
        negDtr = Dtr(~posInd,:);
        [posData, negData] = BiSmote(posDtr, negDtr, k, d);
        XT = [posData;negData];
        group = [ones(size(posData,1),1); zeros(size(negData,1),1)];
        if g==-1
            svmstruct = svmtrain(XT,group);
        else
            svmstruct = svmtrain(XT(:,21:22),group,'kernel_function','rbf');
        end
        
        Y_pred(i,j) = svmclassify(svmstruct,Dts(:,21:22));
    end
end



