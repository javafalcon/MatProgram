% 把cell类型变量X转换为矩阵类型
% X{i}是矩阵的第i行
function A = CellToMatrix(X)
    row = length(X);
    col = length(X{1});
    A = zeros(row,col);
    for i = 1:row
        for j = 1:col
            A(i,j) = X{i}(j);
        end
    end
    