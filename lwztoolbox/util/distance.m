function D = distance( ZI, ZJ, distfun )
%                            
%     1-by-M vector ZI containing a single row of X or Y, an N-by-M 
%     matrix ZJ containing multiple rows of X or Y, and returning
%     an N-by-1 vector of distances D, whose Jth element is the                        
%     distance between the observations ZI and ZJ(J,:).                   
%                           
    if nargin < 3
        distfun = 'euclidean';
    end
    
    if ischar(distfun)
        N = size(ZJ,1);
        D = zeros(N,1);
        switch distfun
            case 'euclidean'
                for i = 1 : N
                    D(i) = sum( (ZI-ZJ(i,:)).^2)^0.5;
                end
            case 'cosin'
                for i = 1 : N
                    D(i) = ZI*ZJ(i,:)'/( ( sum(ZI.^2)^0.5) * ( sum(ZJ(i,:).^2)^0.5));
                end
        end
    else
        D = distfun(ZI,ZJ);
    end
    


end

