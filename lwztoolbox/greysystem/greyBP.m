function [y,e,z,net] = greyBP(x,m,endP)
% x--原始序列;m--训练输入单元数
%1、计算灰色预测序列y
%2、计算灰色模型预测残差序列e
%3、用BP网络训练残差序列
%4、构建新的预测序列z
%5、startP--
P=GMParam(x);
n = length(x);

e = zeros(1,endP);
z = zeros(1,endP);

for k=1:m
    z(k)=x(k);
end

y=simByGM(x,2,endP);
e=x-y(1:n);

%构建BP神经网络训练集P和目标集T
P = zeros(m,n-m);
T = zeros(1,n-m);
col = 0; %列数
row = 0; %行数
k = 1;
for col = 1:n-m
    for row = 1:m
        P(row, col) = e(k);
        k = k+1;
    end
    T(k-m) = e(k);
    k = k - m +1;
end
%训练网络
net = newff(minmax(P),[10,1],{'logsig','purelin'},'traingdx');
net.trainParam.epochs = 5000;
net.trainParam.goal = 0.001;
net.trainParam.lr=0.2;
net = train(net,P,T);

for k = m + 1:n
    an = sim(net,P(:,k-m));
    z(k) = y(k) + an;
end
for k=n+1:endP
    p_test = e(k-m:k-1)';
    e(k) = sim(net,p_test);
    z(k) = y(k) + e(k);
end


