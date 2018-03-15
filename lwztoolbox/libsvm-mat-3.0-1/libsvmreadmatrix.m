function libsvmreadmatrix( data,groups,fname )
%Output libsvm format file from instances matrix 
%data: M by N matrix, each row express an instance
%groups: M column vector, target of instance
[M,N] = size(data);
fd = fopen(fname,'w');
for i = 1 : M
    line = [int2str(groups(i)), ' '];
    for j = 1 : N
        line = [line, int2str(j), ':', num2str(data(i,j)), ' '];
    end
    fprintf(fd,'%s\n',line);
end
fclose(fd);
end

