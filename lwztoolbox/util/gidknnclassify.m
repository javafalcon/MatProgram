%Ԥ��target��ģʽ������Ϊ sample�������ķ������������Group��ӳ��k�ǽ�����
function type = gidknnclassify(target,Sample,Group,k)
 dist = GreyIncidenceDegree(Sample,target);
 [dSort,dIndex]=sort(dist,'descend');
 dIndex = dIndex(1:k);
 classes = Group(dIndex);
 m = max(Group);%��������ģʽ�����
 kind = zeros(1,m);
 for i = 1:k
     kind(classes(i)) = kind(classes(i)) + 1;
 end
 [kSort,kIndex] = sort(kind,'descend');
 type = kIndex(1);
 %if type < (k+1)/2
 %    type = 0;
 %end
 
 
 