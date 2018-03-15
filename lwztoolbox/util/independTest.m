%author:linweizhong
%data:2007-8-24

load Sequence_Data.mat;
load Vector_Group.mat;
load Cov_Data_12.mat;
function independTest(learn,test,
Percent_X=zeros(type,1);
Goodprotein=zeros(type,1);

for i=1:11
    for j=1:Group_Count(i)
        x=Vector_Group{i}{j};
        position_D=0;
        distance=zeros(type,1);
        for k=1:type
            distance(k) = MahalDistance(x,Standard_Vector{k},Covariance_Matrix{k});
        end
        position_D=position(distance,type);      
        if  position_D==i                 
            Goodprotein(i)=Goodprotein(i)+1;
        end
    end
    Percent_X(i)=Goodprotein(i)/Group_Count(i);   
    Percent_X
end

Total_Good=0;
Total_Protein=0;
Total_Percent=0;
for i=1:type
    Total_Good=Total_Good+Goodprotein(i);
    Total_Protein=Total_Protein+Group_Count(i);
end

Total_Percent=Total_Good/Total_Protein
