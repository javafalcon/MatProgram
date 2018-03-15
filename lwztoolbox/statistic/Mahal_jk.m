function Y_pred = Mahal_jk(data,group)

row = size(data,1);
Y_pred = zeros(row,1);
L = max(group);

for i = 1 : row
	trn = true(row,1);
	trn(i) = false;
	
	distance = zeros(L,1);
	for j = 1 : L
		m
	