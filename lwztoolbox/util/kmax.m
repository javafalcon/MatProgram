%������X���ҳ�k������ֵ��������Щֵ��Ӧ���±����
function a = kmax(X,k)
    n = length(X);
    a=[];
    for i = 1:k
        m=0;index=0;
        for j = 1: n
            if X(j) > m && isinclude(a,j)==0
                index = j;
                m = X(j);
            end
        end
        a=[a index];
    end