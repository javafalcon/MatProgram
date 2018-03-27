% P: a 1-by-N cell, PSSM
function glcm = getPSSM_GLCM(p)
    N = size(p,2);
    M = 4;
    glcm=zeros(N,M);

    for i = 1 : N
        D = p{i};
        D=D(:,1:20);
        [row,col] = size(D);
        for r = 1 : row
            for c = 1 : col
                if D(r,c)<0
                    D(r,c) = 256 + D(r,c);
                end
            end
        end
        [ASM_E,CON_E,ENT_E,IDM_E] = GLCM_FEATURE(D);
        glcm(i,:)=[ASM_E CON_E ENT_E IDM_E];
    end
    [glcm,~]=mapminmax(glcm,0,1);