%Author:Lin Wei-Zhong
%Date:2008-1-11
%Version:1.2
%[Percent,Total]=jkGreyIncidence(Vector_Group,Group_Count,k)
%����������������cell�ͱ���Vector_Group����jack-knife���ԣ�����ʹ�û�ɫ�����ȣ��㷨Ϊk�����㷨
%Vector_Group:�������ݼ�
%Group_Count:ÿ�����ݼ��������еĸ���
%k:������
%Percent:ÿ���Ԥ����ȷ��
%Total:��Ԥ����ȷ��
function [Percent,Total]=jkGreyIncidence(Vector_Group,Group_Count,k)
type = length(Group_Count);
Good=zeros(1,type);
%dim =length(Vector_Group{1}{1});
te = sum(Group_Count);
tn = AGO(Group_Count);
%��Vector_Groupת��Ϊ����
T=[];
for i = 1:type
    mat = CellToMatrix(Vector_Group{i});
    T = [T; mat];
end

for i=1:te
    x=T(i,:);%��ʶ��ģʽ��Ԫ��
    %��ʶ���Ԫ�ر�������ģʽt1
    t1 = 1;
    while ( ( i > tn(t1) ) && ( t1 < type) )
        t1 = t1 + 1;
    end
    %jack-knife����
    knn = zeros(1,type);
    S = T;
    S(i,:) = [];%ȥ����������T(i,:)
    cot = Group_Count;
    cot(t1) = cot(t1) -1;%ģʽt1��Ԫ�ظ�����1
    tnn = AGO(cot);
    r=GreyIncidenceDegree(S,x);%x��S����Ԫ�صĻ�ɫ������
%     r = CosinDistance(S,x);
    %r = EuclDistance(S,x);
    %�ӻ�ɫ����������r���ҳ����ֵ���±�inx
    [B,IX]=sort(r);
    kinx = IX(te-k:te-1);
    %ͳ��ÿһ��Ľ�����
    for ii = 1:k
        t2=1;
        %��kinx(ii)���ֵ�ģʽt2
        while (( kinx(ii) > tnn(t2)) && (t2 < type))
            t2=t2+1;
        end
        %ģʽt2�Ľ�������1
        knn(t2) = knn(t2) + 1;
    end
    %��һ�ຬ�������
    [val,I] = max(knn);
    if I == t1
        Good(t1) = Good(t1) + 1;
    end
end
Total=sum(Good)/te;
Percent=Good./Group_Count;
        
        
        