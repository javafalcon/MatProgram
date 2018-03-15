function outclass = greybiknnclassify( sample, Train, group, k )
%greyknnclassify knnclassify by grey incident degree
%   Syntex
%       outclass = greyknnclassify(sample, Train, group, k);
%
%   Input:
%       Train   -An N-by-M matrix, the ith instance is stored in
%               Train(i,:);
%       group   -An N-by-1 matrix, a grouping variable for Train, group(i)
%               =1, or group(i)=0;
%       sample  -An N2-by-M matrix, unknown instance;
%       k       -The number of nearest neighbor;
%
%   Output:
%       outclass    -the predicted output
    N = size(sample,1);
    outclass = zeros(N,1);
    
    data1 = Train(group==1,:);
    data2 = Train(group==0,:);
    
    for i = 1 : N
        [~,dist1] = knnsearch(data1,sample(i,:),'distance',@GIDistance, 'K', k);
    
        [~,dist2] = knnsearch(data2,sample(i,:),'distance',@GIDistance, 'K', k);
        if dist1 < dist2
            outclass(i) = 1;
        end
    end

end

