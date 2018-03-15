function y=position(Distance,k)
Distance_min=min(Distance);
for i=1:k
    if Distance_min==Distance(i)
        y=i;
    end
end    
