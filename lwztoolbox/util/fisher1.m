function [w,y0] = fisher1(data,group)
%���������Fisher�б�
%data:��������
%group_count��ÿһ��������������Ŀ
[row,col] = size(data);
sum = zeros(col,1,2);
count = zeros(1,2);
m = zeros(col,1,2);%ÿ��ľ�ֵ����
s = zeros(col,col,2);%ÿ���Э�������

%�������ֵ����
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

%����������ɢ�Ⱦ���
for i = 1 : row
    if group(i) == 1
        s(:,:,1) = s(:,:,1) + ( data(i,:)' - m(:,1,1)) * ( data(i,:)' - m(:,1,1))';
    elseif group(i) == -1
        s(:,:,2) = s(:,:,2) + ( data(i,:)' - m(:,1,2)) * ( data(i,:)' - m(:,1,2))';
    end
end

%����������������ɢ�Ⱦ���
Sw = s(:,:,1) + s(:,:,2);

%�������������ɢ�Ⱦ���
Sb = ( m(:,1,1) - m(:,1,2)) * ( m(:,1,1) - m(:,1,2))';

%�ⷽ��Sb*w=d*Sw*w

%����1:inv(Sw)*Sb*w=d*w,��inv(Sw)*Sb������������������
% F = Sw\Sb;
% [V,D]=eig(F);

%����2:�󷽳̵Ĺ����������͹�����������
[V,D]=eig(Sb,Sw);%����������������ǰk������Ӧ����������
diagElem = diag(D);
[B,IX]=sort(diagElem,'descend');
w = V(:,IX(1:22));

%����3�� ֱ�Ӽ���
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

