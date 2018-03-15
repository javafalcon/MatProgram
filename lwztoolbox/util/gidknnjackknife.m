%������sampleʹ��knn�㷨����jack knife����
%sample:������.n��m�е����飬n��ʾ������Ŀ��m��ʾÿ������������ά��.
%group:ÿ��������Ӧ��ģʽ
%s�����������������Ϊs���Ӽ�
%k��������
function [good,total] = gidknnjackknife(sample,group,s,k)

[n,m]=size(sample);
good = zeros(1,s);
for i = 1:n
    target = sample(i,:);
    y = sample;
    y(i,:) = [];
    type = gidknnclassify(target,y,group,k);
    if type == group(i)
        good(type) = good(type) + 1;
    end
end
total = sum(good)/n;