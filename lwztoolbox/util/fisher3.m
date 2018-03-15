function w = fisher3(data,group,types,k)
%多类的Fisher判别
[row,col] = size(data);
sum = zeros(col,1,types);
count = zeros(1,types);
m = zeros(col,1,types);%每类的均值向量
s = zeros(col,col,types);%每类的协方差矩阵
%计算类均值向量
for i = 1 : row
    sum(:,1,group(i)) = sum(:,1,group(i)) + data(i,:)';
    count(1,group(i)) = count(1,group(i)) + 1;
end

for i = 1 : types
    m(:,1,i) = sum(:,1,i)/count(1,i);
end


%计算类内离散度矩阵
for i = 1 : row
    s(:,:,group(i)) = s(:,:,group(i)) + ( data(i,:)' - m(:,1,group(i))) * ( data(i,:)' - m(:,1,group(i)))';
end

%计算样本总类内离散度矩阵
Sw = zeros(col,col);
for i = 1 : types
    Sw = Sw + s(:,:,i);
end

%总均值向量
tm = mean(data);
%总类间离散度矩阵
St = zeros(col,col);
for i = 1 : row
    St = St + (data(i,:) - tm)'* (data(i,:) - tm);
end
%计算样本类间离散度矩阵
Sb = St - Sw;
% F = Sw\Sb;
[V,D]=eig(Sb,Sw);
diagElem = diag(D);
[B,IX]=sort(diagElem,'descend');
w = V(:,IX(1:k));

