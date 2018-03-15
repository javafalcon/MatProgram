function y = newInfoGM(X)

% newInfoGM11 ������X�����һ��������Ϊ��ʼֵ����Ϣ��������GM��1,1��ģ�ͽ���Ԥ�⡣

P = GMParam(X);
a = P(1); b = P(2);

n = length(X);
X1 = AGO(X);

for k = 1 : n
    X1(k) = ( X1(n) - b/a) * exp( -a * ( k - n)) + b/a;
end

y = zeros(1,n);
y(1) = X1(1);
for k = 1 : len-1
    y(k) = X1(k+1) - X1(k)
end