%�ɱ�Ȩ��α�����ᷨ��jackknife����
%total = fjk(w,Vector_20_Group,Pse_Group,Group_Count,dim,type)
%     Vector_20_Group �ǵ��������е�20ά������ɷ�����
%     Pse_Group ��α������ɷ�
%     Group_Count ��ÿ��ģʽ�ĵ�������Ŀ
%     dim ��α�������ά��
%     type ��ģʽ��Ŀ
%     p �Ǵ�����
function p = fjk(w,Vector_20_Group,Pse_Group,Group_Count,dim,type)
    Vector_Dimention = 20 + dim;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %            ���ÿһ��ÿһ�����������еĹ�һ������          %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for i = 1:type                %���ÿһ��ÿһ�����������е�������ʽ
        for j = 1:Group_Count(i)
            Vector_Group{i}{j} = zeros(Vector_Dimention,1);             %ÿ������������������ʼ��
            for k = 1:20                                                %������Ԫ��
                Vector_Group{i}{j}(k) = Vector_20_Group{i}{j}(k);       % f(k)
            end
            for k = 1:dim                                 %α������Ԫ��
                Vector_Group{i}{j}(20+k) = Pse_Group{i}{j}(k)*w(k); % w(j)*p(j)
            end
            s = sum(Vector_Group{i}{j});                %����Ԫ�غ�
            Vector_Group{i}{j} = Vector_Group{i}{j}/s;  %��һ������
        end
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %        �ڵ�ǰȨ������ACD���б�ʽ����Jackknife����         %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [percent,total]=jkMahal(Vector_Group,Group_Count,type);
    p = 1-total;