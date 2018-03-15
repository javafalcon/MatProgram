%Author:Lin Wei-Zhong
%Date:2008-2-10 
%Version:1.0
%startweight:权重开始值
%step:权重每次增量步长值
%nloop:设定的循环次数
%AAGroup:20维氨基酸成分向量
%PseGroup:伪氨基成分向量
%Group_Count:每个类含序列数
%type:模式类别数
%fv:最佳预测率
%bw:最佳预测率时的权重
%例：
%sw = [1.0e-15 1.0e-15 1.0e-15 1.0e-15];
%step = 1.0e-016;;
%[bw,fv]=fbestsearch(sw,step,100,AAVector_Group,GLCM_Group,Group_Count,6)；
function [bw,fv]=fbestsearch(startweight,step,nloop,AAGroup,PseGroup,Group_Count,type)
fv = 0.0;
dim = 3; Vector_Dimention = 20 + dim;
wm = [startweight];
for i = 1:nloop-1
    startweight = startweight + step;
    wm = [wm;startweight];
end

for w1 = wm(:,1)'
    for w2 = wm(:,2)'
        for w3 = wm(:,3)'
            %for w4 = wm(:,4)'
                w = [w1 w2 w3 ];%当前权值
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %            求出每一类每一个蛋白质序列的归一化向量          %
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                for i = 1:type                %求出每一类每一个蛋白质序列的向量形式
                    for j = 1:Group_Count(i)
                        Vector_Group{i}{j} = zeros(Vector_Dimention,1);             %每个蛋白质序列向量初始化
                        for k = 1:20                                                %氨基酸元素
                            Vector_Group{i}{j}(k) = AAGroup{i}{j}(k);       % f(k)
                        end
                        for k = 1:dim                                 %伪氨基酸元素
                            Vector_Group{i}{j}(20+k) = PseGroup{i}{j}(k)*w(k); % w(j)*p(j)
                        end
                        s = sum(Vector_Group{i}{j});                %向量元素和
                        Vector_Group{i}{j} = Vector_Group{i}{j}/s;  %归一化向量
                    end
                end
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %        在当前权重下用ACD做判别式进行Jackknife测试         %
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                [percent,total]=jkMahal(Vector_Group,Group_Count,type);
                if total > fv
                    fv = total
                    bw = w
                end
            %end
        end
    end
end
