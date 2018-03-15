function predictStatisInfo(Y_pred, Y)
%Statistic multi label prediction  
%
%   Input:
%       Y_pred  -labels predicted, if i-th instance is predicted j-th label
%               Y_pred(i,j)=1, otherwise Y_pred(i,j)=0
%       Y       -labels of training instance
% amptypes={'antibacterial','anticancell','antifungi','antioxidant','antiParasital',...
%     'antiprotist','antiviral','chemotactic','insecticidal','proteas','spermicidal'};

[N,M]=size(Y);
for i = 1 : M
    ind = (Y(:,i)==1);
    n = sum(Y_pred(ind,i)== Y(ind,i));
   fprintf('%d-th are predicted correctly: %d/%d=%f\n', i,n,sum(ind),n/sum(ind));
end

s = sum(Y, 2);
for i = 1 : M
    n = 0;
    ind = (s==i);
    for j = 1 : N
        if ind(j) == 1
            if sum(abs(Y_pred(j,:) - Y(j,:))) == 0
                n = n + 1;
            end
        end
    end
    fprintf('smaples with %d label(s) are predicted correctly: %d/%d=%f\n', i,n,sum(ind),n/sum(ind));
end
    
    