function trnmodel = FS_SVM_ML_train( X, Y )
% Multi-Label classifier training function with Feature Selecting
% Construct a classifier for each label in which the data features are
% selected by Fisher Score Feature Selecting Algorithm. And the classifying
% algorithm is LibSVM
%
% Input parameters:
%   X   -- a row express an instance
%   Y   -- if i-th instance belongs to j-th leabel, Y(i,j) = 1; 
%          otherwise, Y(i,j) = 0;

 
[~,Q] = size(Y);

% for q = 1 : Q
for q = [13]
    I = ( Y(:,q) == 1);
    SY = Y(:,q)+1;
   
    % Feature selecting by fish score
    out = fsFisher(X,SY);
    m = out.W > mean(out.W);
    SubIndx = out.fList(m);
    trnmodel(q).indx = SubIndx;
    
    % training Q SVMs for each class by Libsvm
%     w1 = sum(I);
%     w0 = sum(~I);
    w1 = 1; w0 = 1;
    %select better parameters by grid select methods
%     [bestC, bestG, bestR] = grid(Y(:,q), X(:,SubIndx), w0, w1);
%     
%     p = ['-c ' num2str(2^bestC) ' -g ' num2str(2^bestG) ' -w0 ' int2str(w1) ' -w1 ' int2str(w0)];
    p = '-t 1';
    trnmodel(q).model = svmtrain(Y(:,q), X(:,SubIndx), p);
    
end %for q

function [bestC, bestG, bestR] = grid(tY, tX, w0, w1)
    str = '-c %f -g %f -w0 %d -w1 %d -h 0 -v 5';
    bestR = -inf;
    
    % loose grid
    c_begin = -15; c_end = 5; c_step = 2;
    g_begin = 5; g_end = -10; g_step = -2;
    c_seq = rang_f(c_begin, c_end, c_step);
    g_seq = rang_f(g_begin, g_end, g_step);
    for c = c_seq
        for g = g_seq
            option = sprintf(str,2^c,2^g,w1,w0);
            rate = svmtrain(tY,tX,option);
            if( bestR < rate)
                bestC = c; bestG = g; bestR = rate;
            end
        end
    end
    
    % fine grid
    c_begin = bestC - 2; c_end = bestC + 2; c_step = 0.25;
    g_begin = bestG - 2; g_end = bestG + 2; g_step = 0.25;
    c_seq = rang_f(c_begin, c_end, c_step);
    g_seq = rang_f(g_begin, g_end, g_step);
    for c = c_seq
        for g = g_seq
            option = sprintf(str,2^c,2^g,w1,w0);
            rate = svmtrain(tY,tX,option);
            if( bestR < rate)
                bestC = c; bestG = g; bestR = rate;
            end
        end
    end
end

function seq = rang_f(begin_val, end_val, step)
    seq = [];
    while (true)
        if (step > 0 && begin_val > end_val)
            break;
        end
        if (step < 0 && begin_val < end_val)
            break;
        end
        seq = [seq, begin_val];
        begin_val = begin_val + step;
    end
end %function rang_f
    
end %top function

