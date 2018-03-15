function saveStatisticValue(Vector_Group,type)
Standard_Vector=cell(1,type);
Covariance_Matrix=cell(1,type);
for i=1:type
    Standard_Vector{i}=StandardVector(Vector_Group{i},0);
    Covariance_Matrix{i}=Covariance(Vector_Group{i},0);
end
save('statistic.mat','Standard_Vector','Covariance_Matrix');