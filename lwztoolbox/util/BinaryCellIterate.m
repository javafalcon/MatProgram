function c=BinaryCellIterate(x,y,z,BinRule)
% b=[1 1 1;1 1 0;1 0 1;1 0 0;0 1 1;0 1 0; 0 0 1;0 0 0];
a = 8 -(x*4+y*2+z);
c=str2double(BinRule(a));


            
        