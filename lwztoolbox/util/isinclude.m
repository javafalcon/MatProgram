function f=isinclude(X,x)
%Ԫ��x�Ƿ�������X�У��ڷ���1�����򷵻�0
n=length(X);
f=0;
for i=1:n
    if x==X(i)
        f = 1;
        break;
    end
end