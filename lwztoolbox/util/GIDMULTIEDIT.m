%�ظ����������MULTIEDIT�㷨
%sample:������.n��m�е����飬n��ʾ������Ŀ��m��ʾÿ������������ά��.
%s�����������������Ϊs���Ӽ�
%k��������
function [v,g]=GIDMULTIEDIT(sample,group,s,k)
y = sample;
edit = 1;
while edit > 0
    [n,m]=size(y);
    %����s���Ӽ�
    x = cell(1,s);
    xgroup = cell(1,s);
    %step 1: ������������ػ���Ϊs���Ӽ�
    %1.1 ����1~N�������
    r = randperm(n);
    %1.2 �����������õ������˳����������
    y = y(r,:);
    group = group(r);
    
    step = round(n/s);
    low = 1;
    high = low + step - 1;

    i = 1;
    while i < s
        x{i}=y(low : high,:);
        xgroup{i}=group(low:high);
        low = high + 1;
        high = low + step - 1;
        i = i + 1;
    end
    x{s} = y(low : n,:);
    xgroup{s}=group(low:n);
    
    %step 2: ������ڷ�����x{(i+1)mods}Ϊ���ռ�����x{i}�е��������࣬����i=1,2,...,s;
    edit = 0;
    for i = 1 : s
        tn = size(x{i},1);%����x{i}����������
        e = [];%��ֵ��������
        r = i +1;
        if r > s
            r = 1;
        end
        for j = 1 : tn
            %ʶ��x{i}(j,:)�����
            type = gidknnclassify(x{i}(j,:), x{r}, xgroup{r}, k);
            
            %���±���ֵ�����
            if type ~= xgroup{i}(j);
                e=[e j];
                edit = edit + 1;
            end
        end
        %step 3: ȥ����������������
        x{i}(e,:) = [];
        xgroup{i}(e) = [];
    end
 
    %step 4: �������µ����������µ�������y��
    y=[];
    group=[];
    for i=1:s
        y=[y;x{i}];
        group=[group xgroup{i}];
    end

    %step 5: �ص�step 1ֱ��û������������������edit = 0ʱ�˳��㷨.

end
v = y;
g = group;








