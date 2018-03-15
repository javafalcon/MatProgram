function [ST, SL] = SMOTE( T, L, N, K, distance )
%SMOTE synthetic samples
%   
%   Syntax
%
%       S = SMOTE(T, N, K)
%
%   Description
%
%   Input:
%       T   -An matrix, the i-th instance of T is stored in T(i,:)
%       L   -An label matrix, L(i,j)=1 if i-th instance labeled j-th class
%            attribute; L(i,j)=0 otherwise.
%       N   -Amount of SMOTE
%       K   -Number of nearest neighbors
%		distance -The name of distance function. Euclid is default value 
%
%   Output:
%       ST   -An N*(size(T,1)) synthetic samples matrix
%       SL   -An label matrix
    
    if nargin < 5
        distance = 'Euclid';
    end

    [numinsts, numattrs] = size(T);
    numclass = size(L,2);
    
%Generating the synthetic samples
    ST = zeros(N*numinsts, numattrs);
    ST(1:numinsts,:) = T;
    SL = zeros(N*numinsts, numclass);
    SL(1:numinsts,:) = L;
    newindex = 1;
    
    for i = 1 : numinsts
        num = 1;
%Computing K nearest neighbors for i-th samples
        idx = true(numinsts,1);
        idx(i) = false;
        X = T(idx,:);
        Y = T(i,:);
        [nnarry, ~] = knnsearch(X,Y,'k',K,'Distance',distance);
                
        while num < N
%   choose a random number between 1 and K, call it nn
%   This step choose one of the K nearest neighbors of i
            nn = randi(K,1);
            for attr = 1 : numattrs
                dif = T(nnarry(nn),attr) - T(i,attr);
                gap = rand; %random number beteen 0 and 1
                ST(newindex,attr) = T(i,attr) + gap*dif;
            end
            SL(newindex,:) = L(i,:);%the synthetic instance is labeled as T(i,:) 
            newindex = newindex + 1;
            num = num + 1;
        end
    end
        

end

