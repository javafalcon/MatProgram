function y=fuzadu(sequence_01)

count=length(sequence_01);
s='';Q='';B='';D='';                      %s-存放前缀，Q-未判断子串，B-存放SQpi，D-存放带有复杂度标志的氨基酸数学符号序列
s=sequence_01(1);
D=[s,'~'];                                %给一些变量赋初值
Q=[Q,sequence_01(2)];

for i=2:count
    B=[s,Q];
    B(:,length(B))=[];                    %删除s＋Q的最后一列，从而确定B
    d=findstr(B,Q);
   
	if length(d)~=0
        D=[D,sequence_01(i)];
        s=s;
        if i~=count                        %如果i到最后一位再做AA(i+1)，就会出错；所以不必做
            Q=[Q,sequence_01(i+1)];
        end    
	else
        D=[D,sequence_01(i),'~'];
        s=[s,Q];
        if i~=count
            Q='';
            Q=[Q,sequence_01(i+1)];
        end   
	end
end
%D;
y=length(findstr(D,'~'))+1;