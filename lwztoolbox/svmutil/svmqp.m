function [a,b]=svmqp(data,group,v)

% data 输入数据
% group 输入数据的类别
% a 支持向量机的对偶问题二次规划的解
% b 

%%
% 构造二次规划问题
[m,n]=size(data);
H = zeros(m,m);
for i = 1 : m
    for j = 1 : m
        %H(i,j) = group(i)*group(j)*agid_kernel(data(i,:),data(j,:));
        H(i,j) = group(i)*group(j)*(data(i,:)*data(j,:)');
    end
end

e = ones(m,1);
f = [];

% 不等式约束
A = -e';
B = -v;

% 等式约束
Aeq = zeros(1,m);
for i = 1 : m
    Aeq(i) = group(i);
end
Beq = 0;

% 变量约束
lb = zeros(m,1);
ub = 1/m * e;

X0 = 1/500*ones(m,1);
%%

%%
% 求解二次规划 
options = optimset('LargeScale','off','MaxIter',600);
a = quadprog(H,f,A,B,Aeq,Beq,lb,ub,X0,options);

% 选取分量a(j)，如果：0=<a(j)<=1/m AND group(j)=1;和分量a(k),如果：0=<a(k)<=1/m AND group(k)=-1
flag1 = false;
flag2 = false;
j = 1; k = 1;
for i = 1 : m
    if ( a(i) < 1/m && a(i) > 0 )
        if ( group(i) == 1)
            j = i;
%             aj = a(i);
            flag1 = true;
        else 
            k = i;
%             ak = a(i);
            flag2 = true;
        end
    end
    
    if (flag1 && flag2) 
            break;
    end
    
end

% 计算b
b = 0;
for i = 1 : m
%     b = b + group(i)*a(i)*agid_kernel(data(i,:),data(k,:));
    b = b + group(i)*a(i)*( data(i,:)*data(j,:)' + data(i,:)*data(k,:)');
end

b = -1/2*b;
    

