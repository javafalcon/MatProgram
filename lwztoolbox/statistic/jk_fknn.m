function Y_pred = jk_fknn(data, group, varargin)
%	input:
%		data 		A N by M matrix, where data(i,:) express the i-th sample.
%		group		A N by Q matrix, where group(i,j) = 1 if the i-th sample is belong to j-th class; 
%					otherwise group(i,j) = 0.
%		Y_pred=jk_fknn(data,group,'PARAM1',val1,'PARAM2',val2,...) specifies optional
%   	parameter name/value pairs:
%			Name 				Value
%			'K'					A integer, 'K', specifying the number of nearest neighbour.
%			'DistanceWeight'	A integer, 'DistanceWeight', specifying distance weight.
%	Output:
%		Y_pred		A N by Q matrix predicted labels.

	pnames = {'K', 'DistanceWeight'};
	dflts = {'11', '2'};
	[k,m] = internal.stats.parseArgs( pnames, dflts, varargin{:});
	
	[N,Q] = size(group);
	Y_pred = zeros(N,Q);
	
	for i = 1 : N
		indx = true(N,1);
		indx(i) = false;
		trnX = data(indx,:);
		trnY = group(indx,:);
		test = data(i,:);
		
		[Y_pred(i,:), memberships] = fknn(data, labels, test, k, m)
end