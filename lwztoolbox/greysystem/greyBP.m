function [y,e,z,net] = greyBP(x,m,endP)
% x--ԭʼ����;m--ѵ�����뵥Ԫ��
%1�������ɫԤ������y
%2�������ɫģ��Ԥ��в�����e
%3����BP����ѵ���в�����
%4�������µ�Ԥ������z
%5��startP--
P=GMParam(x);
n = length(x);

e = zeros(1,endP);
z = zeros(1,endP);

for k=1:m
    z(k)=x(k);
end

y=simByGM(x,2,endP);
e=x-y(1:n);

%����BP������ѵ����P��Ŀ�꼯T
P = zeros(m,n-m);
T = zeros(1,n-m);
col = 0; %����
row = 0; %����
k = 1;
for col = 1:n-m
    for row = 1:m
        P(row, col) = e(k);
        k = k+1;
    end
    T(k-m) = e(k);
    k = k - m +1;
end
%ѵ������
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


