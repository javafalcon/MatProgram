% ��cell���ͱ���Xת��Ϊ��������
% X{i}�Ǿ���ĵ�i��
function A = CellToMatrix(X)
    row = length(X);
    col = length(X{1});
    A = zeros(row,col);
    for i = 1:row
        for j = 1:col
            A(i,j) = X{i}(j);
        end
    end
    