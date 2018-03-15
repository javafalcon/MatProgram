%在序列X中找出k个最大的值，返回这些值相应的下标序号
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