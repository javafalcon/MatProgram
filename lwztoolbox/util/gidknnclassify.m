%预测target的模式。样本为 sample，样本的分类情况由数组Group反映，k是近邻数
function type = gidknnclassify(target,Sample,Group,k)
 dist = GreyIncidenceDegree(Sample,target);
 [dSort,dIndex]=sort(dist,'descend');
 dIndex = dIndex(1:k);
 classes = Group(dIndex);
 m = max(Group);%样本集的模式类别数
 kind = zeros(1,m);
 for i = 1:k
     kind(classes(i)) = kind(classes(i)) + 1;
 end
 [kSort,kIndex] = sort(kind,'descend');
 type = kIndex(1);
 %if type < (k+1)/2
 %    type = 0;
 %end
 
 
 