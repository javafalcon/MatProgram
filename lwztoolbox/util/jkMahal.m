%author:linweizhong
%data:2008-1-28
%[percent,total]=jkMahal(Vector_Group,Group_Count,type)
%�����ݼ�Vetor_Group����jackknife�������ԣ������������Ͼ�����Ϊ�жϱ�׼.
%@ param Vector_Group  cell�ͱ���i�У�j�У�Vector_Group{i}{j}��ʾ��i���Ӽ��е�j������������
%@ param Group_Count ÿ���Ӽ�����Ŀ,������
%@ param type ģʽ������Ŀ
%@ return percent ÿ���Ԥ�⾫��
%@ return total ��Ԥ�⾫��
function [percent,total]=jkMahal(Vector_Group,Group_Count,type)
% Step 1: Calculate the standard vector,covariance matrix,eigenvalues and eigenvectors of all kinds
for i=1:type
    Standard_Vector{i}=StandardVector(Vector_Group{i},0);
    Covariance_Matrix{i}=Covariance(Vector_Group{i},0);
end
% Step 2: Jacknife 
Goodprotein=zeros(1,type);
for i=1:type
    for j=1:Group_Count(i)
        x=Vector_Group{i}{j};
        distance=zeros(type,1);
        % Step 2.1: Calculate the standard vector and covariance matrix
        % of Vector_Group{i} which exclude Vector_Group{i}{j}. 
        sv=StandardVector(Vector_Group{i},j);
        cm=Covariance(Vector_Group{i},j);
        % Step 2.2: Calculate the distance of x to all kinds
        for k=1:type
            if k == i
                distance(k) = MahalDistance(x,sv,cm);
            else
                distance(k) = MahalDistance(x,Standard_Vector{k},Covariance_Matrix{k});
            end
        end
        % Step 2.3: To decide in which kind x is  
        %position_D=position(distance,type); 
        [val,position_D]=min(distance);
        if  position_D==i                 
            Goodprotein(i)=Goodprotein(i)+1;
        end
    end
end
percent = Goodprotein./Group_Count;
total=sum(Goodprotein)/sum(Group_Count);
