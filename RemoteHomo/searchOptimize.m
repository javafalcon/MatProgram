maxv = 0;
opX=[0 0 0 0];
for x1 = 0.1:0.1:1
    for x2 = 0.1:0.1:1-x1
        for x3 = 0.1:0.1:1-x1-x2 
            x4 = 1-x1-x2-x3;
            if x4 > 0
                Auc50 = main_3187seqs([x1 x2 x3 x4]);
                if Auc50 > maxv
                    maxv = Auc50;
                    opX = [x1 x2 x3 x4];
                    fprintf('maxv=%f, x=[%f %f %f %f]\n',maxv,opX);
                end
            end
        end
    end
end

for x1 = opX(1)-0.05: 0.01 : opX(1)+0.05
    for x2 = opX(2)-0.05: 0.01 : opX(2)+0.05
        for x3 = opX(3)-0.05: 0.01 : opX(3)+0.05
            x4 = 1-x1-x2-x3;
            if x4 > 0
                Auc50 = main_3187seqs([x1 x2 x3 x4]);
                if Auc50 > maxv
                    maxv = Auc50;
                    opX = [x1 x2 x3 x4];
                    fprintf('maxv=%f, x=[%f %f %f %f]\n',maxv,opX);
                end
            end   
        end
    end
end
% eula distance:maxv=0.801463, x=[0.640000 0.060000 0.070000 0.230000]
% gid distance:maxv=0.779178, x=[0.190000 0.630000 0.180000 0.000000]