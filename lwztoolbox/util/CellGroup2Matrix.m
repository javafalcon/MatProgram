function M=CellGroup2Matrix(Group)
M=[];
len=length(Group);
for i=1:len
    A=CellToMatrix(Group{i});
    M=[M;A];
end
