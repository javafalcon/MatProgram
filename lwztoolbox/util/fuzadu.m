function y=fuzadu(sequence_01)

count=length(sequence_01);
s='';Q='';B='';D='';                      %s-���ǰ׺��Q-δ�ж��Ӵ���B-���SQpi��D-��Ŵ��и��Ӷȱ�־�İ�������ѧ��������
s=sequence_01(1);
D=[s,'~'];                                %��һЩ��������ֵ
Q=[Q,sequence_01(2)];

for i=2:count
    B=[s,Q];
    B(:,length(B))=[];                    %ɾ��s��Q�����һ�У��Ӷ�ȷ��B
    d=findstr(B,Q);
   
	if length(d)~=0
        D=[D,sequence_01(i)];
        s=s;
        if i~=count                        %���i�����һλ����AA(i+1)���ͻ�������Բ�����
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