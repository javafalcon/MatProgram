function w = fisher3(data,group,types,k)
%�����Fisher�б�
[row,col] = size(data);
sum = zeros(col,1,types);
count = zeros(1,types);
m = zeros(col,1,types);%ÿ��ľ�ֵ����
s = zeros(col,col,types);%ÿ���Э�������
%�������ֵ����
for i = 1 : row
    sum(:,1,group(i)) = sum(:,1,group(i)) + data(i,:)';
    count(1,group(i)) = count(1,group(i)) + 1;
end

for i = 1 : types
    m(:,1,i) = sum(:,1,i)/count(1,i);
end


%����������ɢ�Ⱦ���
for i = 1 : row
    s(:,:,group(i)) = s(:,:,group(i)) + ( data(i,:)' - m(:,1,group(i))) * ( data(i,:)' - m(:,1,group(i)))';
end

%����������������ɢ�Ⱦ���
Sw = zeros(col,col);
for i = 1 : types
    Sw = Sw + s(:,:,i);
end

%�ܾ�ֵ����
tm = mean(data);
%�������ɢ�Ⱦ���
St = zeros(col,col);
for i = 1 : row
    St = St + (data(i,:) - tm)'* (data(i,:) - tm);
end
%�������������ɢ�Ⱦ���
Sb = St - Sw;
% F = Sw\Sb;
[V,D]=eig(Sb,Sw);
diagElem = diag(D);
[B,IX]=sort(diagElem,'descend');
w = V(:,IX(1:k));

