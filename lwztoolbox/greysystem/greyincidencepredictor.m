%[Percent,Total]=greyincidencepredictor(S,T,m,si,ti,K)
%S:ѵ�������������͡�S=S1US2US3U...USm
%T:���Լ����������͡�T=T1UT2UT3U...UTm
%m:ģʽ��
%K:KNN�㷨�Ĵ��ڲ���K
%sindex:ѵ�����������Ԫ�ص���Ŀ
%tindex:���Լ��������Ԫ�ص���Ŀ
%�������ܣ��û��ڻ�ɫ�����ȵ�������㷨(KNN)�Բ��Լ�Y����Ԥ�⡣�ó�������ȷ��ʶ���ʺ��ܵ�ʶ���ʡ�
function [Percent,Total]=greyincidencepredictor(S,T,m,si,ti,K)
Good = zeros(1,m);
te = sum(ti);%���Լ�����
sn = AGO(si);
tn = AGO(ti);
for i=1:te
    x=T(i,:);%��ʶ��ģʽ��Ԫ��
    %��ʶ���Ԫ�ر�������ģʽt1
    t1 = 1;
    while ( ( i > tn(t1) ) && ( t1 < m) )
        t1 = t1 + 1;
    end
    nn = zeros(1,m);
    r=GreyIncidenceDegree(S,x);%x��S����Ԫ�صĻ�ɫ������
    %�ӻ�ɫ����������r���ҳ�k�����ֵ���±�
    kinx=kmax(r,K);
    %ͳ��ÿһ��Ľ�����
    for ii = 1:K
        t2=1;
        %��kinx(ii)���ֵ�ģʽt
        while (( kinx(ii) > sn(t2)) && (t2<m))
            t2=t2+1;
        end
        %ģʽt�Ľ�������1
        nn(t2) = nn(t2) + 1;
    end
    %��һ�ຬ�������
    type = kmax(nn,1);
    if type == t1
        Good(type) = Good(type) + 1;
    end
end
Total=sum(Good)/te;
Percent=Good./ti;

