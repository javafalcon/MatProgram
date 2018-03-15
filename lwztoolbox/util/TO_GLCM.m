function [B,C] = TO_GLCM(A)
% ��0-1�ַ�����A��ˮƽ�ʹ�ֱ����ĻҶȹ�������offset=1
% ����GLCMҪ��׼��
% 2007��10��16�ձ�

% ����ˮƽ����GLCM
B = zeros(2);   % E  matrix,�Ҷȼ�ֻ��0��1
C = zeros(2);   % N  matrix
[n,p] = size(A);
NUM = (p-1)*n*2;  % ���ض�֮��
temp = '';
for i = 1:n
    for j = 1:(p-1)
        temp = [A(i,j),A(i,j+1)];
        switch temp
            case '00'
                B(1,1) = B(1,1) + 1;
            case '01'
                B(1,2) = B(1,2) + 1;
            %case '02'
            %    B(1,3) = B(1,3) + 1;
            %case '03'
            %    B(1,4) = B(1,4) + 1;
            case '10'
                B(2,1) = B(2,1) + 1;
            case '11'
                B(2,2) = B(2,2) + 1;
            %case '12'
            %    B(2,3) = B(2,3) + 1;
            %case '13'
            %    B(2,4) = B(2,4) + 1;
            %case '20'
            %    B(3,1) = B(3,1) + 1;
            %case '21'
            %    B(3,2) = B(3,2) + 1;
            %case '22'
            %    B(3,3) = B(3,3) + 1;
            %case '23'
            %    B(3,4) = B(3,4) + 1;
            %case '30'
            %    B(4,1) = B(4,1) + 1;
            %case '31'
            %    B(4,2) = B(4,2) + 1;
            %case '32'
            %    B(4,3) = B(4,3) + 1;
            %case '33'
            %    B(4,4) = B(4,4) + 1;
            otherwise
                break
        end
    end
end
for i = 1:n
    for j = p:(-1):2
        temp = [A(i,j),A(i,j-1)];
        switch temp
            case '00'
                B(1,1) = B(1,1) + 1;
            case '01'
                B(1,2) = B(1,2) + 1;
            %case '02'
            %    B(1,3) = B(1,3) + 1;
            %case '03'
            %    B(1,4) = B(1,4) + 1;
            case '10'
                B(2,1) = B(2,1) + 1;
            case '11'
                B(2,2) = B(2,2) + 1;
            %case '12'
            %    B(2,3) = B(2,3) + 1;
            %case '13'
            %    B(2,4) = B(2,4) + 1;
            %case '20'
            %    B(3,1) = B(3,1) + 1;
            %case '21'
            %    B(3,2) = B(3,2) + 1;
            %case '22'
            %    B(3,3) = B(3,3) + 1;
            %case '23'
            %    B(3,4) = B(3,4) + 1;
            %case '30'
            %    B(4,1) = B(4,1) + 1;
            %case '31'
            %    B(4,2) = B(4,2) + 1;
            %case '32'
            %    B(4,3) = B(4,3) + 1;
            %case '33'
            %    B(4,4) = B(4,4) + 1;
            otherwise
                break
        end
    end
end
%B=B/NUM;     % �õ�����ÿ�����ض���ˮƽ������ֵĸ���

% ���㴹ֱ����GLCM
NUM = (n-1)*p*2;
for j = 1:p
    for i = 1:(n-1)
        temp = [A(i,j),A(i+1,j)];
        switch temp
            case '00'
                C(1,1) = C(1,1) + 1;
            case '01'
                C(1,2) = C(1,2) + 1;
            %case '02'
            %    C(1,3) = C(1,3) + 1;
            %case '03'
            %    C(1,4) = C(1,4) + 1;
            case '10'
                C(2,1)=C(2,1)+1;
            case '11'
                C(2,2) = C(2,2) + 1;
            %case '12'
            %    C(2,3) = C(2,3) + 1;
            %case '13'
            %    C(2,4)=C(2,4)+1;
            %case '20'
            %    C(3,1) = C(3,1) + 1;
            %case '21'
            %    C(3,2) = C(3,2) + 1;
            %case '22'
            %    C(3,3) = C(3,3) + 1;
            %case '23'
            %    C(3,4) = C(3,4) + 1;
            %case '30'
            %    C(4,1) = C(4,1) + 1;
            %case '31'
            %    C(4,2) = C(4,2) + 1;
            %case '32'
            %    C(4,3) = C(4,3) + 1;
            %case '33'
            %    C(4,4) = C(4,4) + 1;
            otherwise
                break
        end
    end
end
for j = 1:p
    for i = n:(-1):2
        temp = [A(i,j),A(i-1,j)];
        switch temp
            case '00'
                C(1,1) = C(1,1) + 1;
            case '01'
                C(1,2) = C(1,2) + 1;
            %case '02'
            %    C(1,3) = C(1,3) + 1;
            %case '03'
            %    C(1,4) = C(1,4) + 1;
            case '10'
                C(2,1) = C(2,1) + 1;
            case '11'
                C(2,2) = C(2,2) + 1;
            %case '12'
            %    C(2,3) = C(2,3) + 1;
            %case '13'
            %    C(2,4) = C(2,4) + 1;
            %case '20'
            %    C(3,1) = C(3,1) + 1;
            %case '21'
            %    C(3,2) = C(3,2) + 1;
            %case '22'
            %    C(3,3) = C(3,3) + 1;
            %case '23'
            %    C(3,4) = C(3,4) + 1;
            %case '30'
            %    C(4,1) = C(4,1) + 1;
            %case '31'
            %    C(4,2) = C(4,2) + 1;
            %case '32'
            %    C(4,3) = C(4,3) + 1;
            %case '33'
            %    C(4,4) = C(4,4) + 1;
            otherwise
                break
        end
    end
end
%C = C/NUM;     % �õ�����ÿ�����ض��ڴ�ֱ������ֵĸ���
