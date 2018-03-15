function [w,y0] = fisher1(data,group)
%两类问题的Fisher判别
%data:样本数据
%group_count：每一类别包含样本的数目
[row,col] = size(data);
sum = zeros(col,1,2);
count = zeros(1,2);
m = zeros(col,1,2);%每类的均值向量
s = zeros(col,col,2);%每类的协方差矩阵

%计算类均值向量
for i = 1 : row
    if group(i) == 1
        sum(:,1,1) = sum(:,1,1) + data(i,:)';
        count(1,1) = count(1,1) + 1;
    elseif group(i) == -1
        sum(:,1,2) = sum(:,1,2) + data(i,:)';
        count(1,2) = count(1,2) + 1;
    end
end
m(:,1,1) = sum(:,1,1)/count(1,1);
m(:,1,2) = sum(:,1,2)/count(1,2);

%计算类内离散度矩阵
for i = 1 : row
    if group(i) == 1
        s(:,:,1) = s(:,:,1) + ( data(i,:)' - m(:,1,1)) * ( data(i,:)' - m(:,1,1))';
    elseif group(i) == -1
        s(:,:,2) = s(:,:,2) + ( data(i,:)' - m(:,1,2)) * ( data(i,:)' - m(:,1,2))';
    end
end

%计算样本总类内离散度矩阵
Sw = s(:,:,1) + s(:,:,2);

%计算样本类间离散度矩阵
Sb = ( m(:,1,1) - m(:,1,2)) * ( m(:,1,1) - m(:,1,2))';

%解方程Sb*w=d*Sw*w

%方法1:inv(Sw)*Sb*w=d*w,求inv(Sw)*Sb的特征根和特征向量
% F = Sw\Sb;
% [V,D]=eig(F);

%方法2:求方程的广义特征根和广义特征向量
[V,D]=eig(Sb,Sw);%计算最大的特征根（前k个）对应的特征向量
diagElem = diag(D);
[B,IX]=sort(diagElem,'descend');
w = V(:,IX(1:22));

%方法3： 直接计算
% w = Sw\( m(:,1,1) - m(:,1,2));

w=w/norm(w);
y0=0;
% y = data * w;
% sum1 = 0; sum2 = 0;
% for i = 1 : row
%     if group(i) == 1
%         sum1 = sum1 + y(i);
%     elseif group(i) == -1;
%         sum2 = sum2 + y(i);
%     end
% end
% m1 = sum1/count(1,1);
% m2 = sum2/count(1,2);
% y0 = (m1 + m2)/2;

