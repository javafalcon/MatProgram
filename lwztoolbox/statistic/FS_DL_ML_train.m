function model = FS_DL_ML_train( X, Y, varargin )
% Multi-Label classifier training function with Feature Selecting
% Construct a classifier for each label in which the data features are
% selected by Fisher Score Feature Selecting Algorithm
%
% Input parameters:
%   X   -- a row express an instance
%   Y   -- if i-th instance belongs to j-th leabel, Y(i,j) = 1; 
%          otherwise, Y(i,j) = 0;

pnames = {'sizes', 'numepochs', 'batchsize', 'momentum', 'alpha', 'unfold', 'activeFun'};
dflts = {[100 100],1,100,0,1,10,'sigm'};
[sizes,numepochs,batchsize,momentum,alpha,unfold,activeFun] = internal.stats.parseArgs( pnames, dflts, varargin{:});
 
[N,Q] = size(Y);

for q = 1 : Q
    I = ( Y(:,q) == 1);
    SY = Y(:,q)+1;
    
    % Feature selecting by fish score
    out = fsFisher(X,SY);
    m = out.W > mean(out.W);
    SubIndx = out.fList(m);
    model(q).indx = SubIndx;
    
    % training a DBN by Deep Learning
    rand('state',0);
    dbn.sizes = sizes;
    opts.numepochs = numepochs;
    opts.batchsize = batchsize;
    opts.momentum = momentum;
    opts.alpha = alpha;
    
    dbn = dbnsetup(dbn, X(:,SubIndx), opts);
    dbn = dbntrain(dbn, X(:,SubIndx), opts);
    
    % unfold dbn to nn
    nn = dbnunfoldtonn(dbn, unfold);
    nn.activation_function = activeFun;
    
    % train nn
    opts.numepochs = numepochs;
    opts.batchsize = batchsize;
    DY = zeros(N,2);
    DY(I,1) = 1; DY(~I,2) = 1;
    nn = nntrain(nn, X(:,SubIndx), DY, opts);
    
    model(q).nn = nn;
    
end %for q
    
    
end

