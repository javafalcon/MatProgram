%可变权重伪氨基酸法的jackknife测试
%total = fjk(w,Vector_20_Group,Pse_Group,Group_Count,dim,type)
%     Vector_20_Group 是蛋白质序列的20维氨基酸成份向量
%     Pse_Group 是伪氨基酸成分
%     Group_Count 是每个模式的蛋白质数目
%     dim 是伪氨基酸的维数
%     type 是模式数目
%     p 是错判率
function p = fjk(w,Vector_20_Group,Pse_Group,Group_Count,dim,type)
    Vector_Dimention = 20 + dim;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %            求出每一类每一个蛋白质序列的归一化向量          %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for i = 1:type                %求出每一类每一个蛋白质序列的向量形式
        for j = 1:Group_Count(i)
            Vector_Group{i}{j} = zeros(Vector_Dimention,1);             %每个蛋白质序列向量初始化
            for k = 1:20                                                %氨基酸元素
                Vector_Group{i}{j}(k) = Vector_20_Group{i}{j}(k);       % f(k)
            end
            for k = 1:dim                                 %伪氨基酸元素
                Vector_Group{i}{j}(20+k) = Pse_Group{i}{j}(k)*w(k); % w(j)*p(j)
            end
            s = sum(Vector_Group{i}{j});                %向量元素和
            Vector_Group{i}{j} = Vector_Group{i}{j}/s;  %归一化向量
        end
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %        在当前权重下用ACD做判别式进行Jackknife测试         %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [percent,total]=jkMahal(Vector_Group,Group_Count,type);
    p = 1-total;