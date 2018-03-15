function triVec = triadVector(sequence)

%traidVector �Ѱ���������תΪ������ɷ�������ÿ�����������7�������е�ĳһ�飬
% ��������7*7*7=343�����������塣����343��������ɷ��ڰ�������������ռ�ı���

len = length(sequence);
triVec = zeros(343,1);

%%
% �Ѱ��������б�Ϊ�������У�ÿ������������7���е�һ�飬�ֱ���0~6�����ֱ�ʾ
digalVec = zeros(1,len);
for i = 1 : len
    switch sequence(i)
        case {'A','G','V'}
           digalVec(i) = 0;
        case {'I','L','F','P'}
            digalVec(i) = 1;
        case {'Y','M','T','S'}
            digalVec(i) = 2;
        case {'H','N','Q','W'}
            digalVec(i) = 3;
        case {'R','K'}
            digalVec(i) = 4;
        case {'D','E'}
            digalVec(i) = 5;
        case {'C'}
            digalVec(i) = 6;
        otherwise
    end
end
%%
% ��������ɷ�������ÿ����������Թ���һ��7���Ƶ�3λ������000~666��ת��Ϊʮ����
% Ϊ��0~342����
for i = 1 : len - 2
    x = digalVec(i);
    y = digalVec(i+1);
    z = digalVec(i+2);
    
    index = x*49 + y*7 + z + 1;
    triVec(index) = triVec(index) + 1; %������ɷֳ��ֵĴ�����1�� 
end

%%
% �淶��������ɷ�����
triVec = ( triVec - min(triVec)) / max(triVec);
    