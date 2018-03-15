function y=method84(Sequence_01)

Sequence_Count=length(Sequence_01);
Selthree='';
New_Sequence='';
for i=1:Sequence_Count
    if i==1
        Selthree=[Sequence_01(Sequence_Count),Sequence_01(1),Sequence_01(2)];
    elseif i==Sequence_Count
        Selthree=[Sequence_01(Sequence_Count-1),Sequence_01(Sequence_Count),Sequence_01(1)];
    else 
        Selthree=[Sequence_01(i-1),Sequence_01(i),Sequence_01(i+1)];
    end
    switch Selthree
        case '111'
            cc='0';
        case '110'
            cc='1';
        case '101'
            cc='0';
        case '100'
            cc='1';
        case '011'
            cc='0';
        case '010'
            cc='1';
        case '001'
            cc='0';
        case '000'
            cc='0';
     end
    New_Sequence=[New_Sequence,cc];   
    Selthree='';
end    
y=New_Sequence;