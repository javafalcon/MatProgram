function M=MomentsFeature(img,n)
M=[];
for i = 0 : n
    for j = i : -2: 0
        [A_nm,~,~,~]=zernike(img,i,j);
        M=[M log(abs(A_nm))];
    end
end
        
