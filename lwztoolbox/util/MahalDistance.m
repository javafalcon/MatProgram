%author:linweizhong.2007-7-21
%s:��ֵ��������������
%c:Э�������
%�������ã���������x�������ľ��룬������ֵΪs,Э�������Ϊc
function md=MahalDistance(x,s,c)
    [V,D]=eig(c);
    Vector_Dimention = length(x);
    lga = 0;a=1;
    %a = (D(2,2)*D(3,3)*D(4,4)*D(5,5)*D(6,6)*D(7,7)*D(8,8)*D(9,9)*D(10,10)*D(11,11)*D(12,12)*D(13,13)*D(14,14)*D(15,15)*D(16,16)*D(17,17)*D(18,18)*D(19,19)*D(20,20)*D(21,21)*D(22,22));
    for i=2:Vector_Dimention
        if D(i,i) > 0
                a = a*D(i,i);
        end
    end
    lga=log(a);
    distance_D = 0;
    for i=2:Vector_Dimention
        %V(:,i)�ǵ�i������ֵ��Ӧ����������
        d = (x-s)'*V(:,i);
        distance_D = distance_D + d^2/D(i,i);
    end
    md=distance_D+lga;