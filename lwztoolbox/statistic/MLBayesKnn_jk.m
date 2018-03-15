function MLBayesKnn_jk( data,group,K,S )
%MLBayesKnn_jk make jack knife test by MLBayesKnn
%K: the num of nearest neighbor
%S: the smooth coefficient
%% 
[N,M] = size(group);
Y_pred = zeros(N,M);
%% Compute priPob and priProbN
cont = sum(group,1);
priProb = cont/sum(cont);
priProbN = 1 - priProb;

%% Jack-knife test
for i = 1 : N
    disp(strcat('Predicting instance:',int2str(i)));
    indx = true(N,1);
    indx(i) = false;
    Xt = data(i,:);
    XT = data(indx,:);
    YT = group(indx,:);
    %% training
    [postProb, postProbN] = MLBayesKnn_train(XT, YT, K, S );
    %% testing
    Y_pred(i,:) = MLBayesKnn_test( Xt, XT, YT, postProb, postProbN, K, priProb, priProbN);
end
% output predicting result
% fileID = fopen('predresult.txt','a');
% fprintf(fileID, '\n MLBayesKnn training and testing');
% fprintf(fileID,'\nFeature: Grey(2,1) PseAAC with code=6, K=%d',K);
h = HammingLoss(group,Y_pred);
disp(strcat('HammingLoss: ',num2str(h)));
% fprintf(fileID, '\nHamming Loss is %6.4f :\n', h);
a = MLAccuracy(group,Y_pred);
disp(strcat('Accuracy: ',num2str(a)));
% fprintf(fileID,'Accuracy is %6.4f:\n', a);
p = MLPrecision(group,Y_pred);
disp(strcat('Precision: ',num2str(p)));
% fprintf(fileID, 'Precision accuracy is %6.4f :\n', p);
r = MLRecall(group,Y_pred);
disp(strcat('Recall: ', num2str(r)));
% fprintf(fileID, 'Recall accuracy is %6.4f :\n', r);
f = MLFMeasure(group,Y_pred);
disp(strcat('FMeasure: ', num2str(f)));
% fprintf(fileID, 'F-measure accuracy is %6.4f :\n', f);
s = SubsetAcc(group,Y_pred);
disp(strcat('Subset Accuracy: ', num2str(s)));
% fprintf(fileID, 'Subset accuracy is %6.4f :\n', s);
% fclose(fileID);
predictStatisInfo(Y_pred, group);
end %end for function

