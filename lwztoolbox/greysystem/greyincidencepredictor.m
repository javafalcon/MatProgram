%[Percent,Total]=greyincidencepredictor(S,T,m,si,ti,K)
%S:训练集，矩阵类型。S=S1US2US3U...USm
%T:测试集，矩阵类型。T=T1UT2UT3U...UTm
%m:模式数
%K:KNN算法的窗口参数K
%sindex:训练集各类包含元素的数目
%tindex:测试集各类包含元素的数目
%函数功能：用基于灰色关联度的最近邻算法(KNN)对测试集Y分类预测。得出各类正确的识别率和总的识别率。
function [Percent,Total]=greyincidencepredictor(S,T,m,si,ti,K)
Good = zeros(1,m);
te = sum(ti);%测试集总数
sn = AGO(si);
tn = AGO(ti);
for i=1:te
    x=T(i,:);%待识别模式的元素
    %待识别的元素本该属于模式t1
    t1 = 1;
    while ( ( i > tn(t1) ) && ( t1 < m) )
        t1 = t1 + 1;
    end
    nn = zeros(1,m);
    r=GreyIncidenceDegree(S,x);%x与S所有元素的灰色关联度
    %从灰色关联度序列r中找出k个最大值的下标
    kinx=kmax(r,K);
    %统计每一类的近邻数
    for ii = 1:K
        t2=1;
        %把kinx(ii)划分到模式t
        while (( kinx(ii) > sn(t2)) && (t2<m))
            t2=t2+1;
        end
        %模式t的近邻数加1
        nn(t2) = nn(t2) + 1;
    end
    %哪一类含近邻最多
    type = kmax(nn,1);
    if type == t1
        Good(type) = Good(type) + 1;
    end
end
Total=sum(Good)/te;
Percent=Good./ti;

