%GPCRԤ����
%t = GPCRpredictor(x,s,Group_Count,k)
%x:��Ԥ��ĵ�����.��������
%S:ѵ��������.S=S1US2U...USm��ÿ�д���һ���������������С�
%Group_Count:�����Ӽ�Si��������
%m:�Ӽ�����.
%K:������
%t:����ֵ��Ԥ��x����St�Ӽ�
function t = GKNNpred(x,S,Group_Count,m,K)
%��KNN�㷨��ϻ�ɫ������
R = GreyIncidenceDegree(S,x);
si = AGO(Group_Count);
[C,IX]=sort(R,'descend');%�Թ����Ƚ������С�
knn = zeros(1,m);%��¼ÿһ��Ľ�����
for t = 1:K
    m=1;
    while( IX(t) > si(m)) 
        m=m+1;
    end
    knn(m) = knn(m)+1;%��IX(t)��Ϊm��
end
[val,t] = max(knn);%������������ģʽ��kind�࣬����x��Ϊ��t�ࡣ