%Author:Lin Wei-Zhong
%Date:2008-2-10 
%Version:1.0
%startweight:Ȩ�ؿ�ʼֵ
%step:Ȩ��ÿ����������ֵ
%nloop:�趨��ѭ������
%AAGroup:20ά������ɷ�����
%PseGroup:α�����ɷ�����
%Group_Count:ÿ���ຬ������
%type:ģʽ�����
%fv:���Ԥ����
%bw:���Ԥ����ʱ��Ȩ��
%����
%sw = [1.0e-15 1.0e-15 1.0e-15 1.0e-15];
%step = 1.0e-016;;
%[bw,fv]=fbestsearch(sw,step,100,AAVector_Group,GLCM_Group,Group_Count,6)��
function [bw,fv]=fbestsearch(startweight,step,nloop,AAGroup,PseGroup,Group_Count,type)
fv = 0.0;
dim = 3; Vector_Dimention = 20 + dim;
wm = [startweight];
for i = 1:nloop-1
    startweight = startweight + step;
    wm = [wm;startweight];
end

for w1 = wm(:,1)'
    for w2 = wm(:,2)'
        for w3 = wm(:,3)'
            %for w4 = wm(:,4)'
                w = [w1 w2 w3 ];%��ǰȨֵ
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %            ���ÿһ��ÿһ�����������еĹ�һ������          %
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                for i = 1:type                %���ÿһ��ÿһ�����������е�������ʽ
                    for j = 1:Group_Count(i)
                        Vector_Group{i}{j} = zeros(Vector_Dimention,1);             %ÿ������������������ʼ��
                        for k = 1:20                                                %������Ԫ��
                            Vector_Group{i}{j}(k) = AAGroup{i}{j}(k);       % f(k)
                        end
                        for k = 1:dim                                 %α������Ԫ��
                            Vector_Group{i}{j}(20+k) = PseGroup{i}{j}(k)*w(k); % w(j)*p(j)
                        end
                        s = sum(Vector_Group{i}{j});                %����Ԫ�غ�
                        Vector_Group{i}{j} = Vector_Group{i}{j}/s;  %��һ������
                    end
                end
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %        �ڵ�ǰȨ������ACD���б�ʽ����Jackknife����         %
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                [percent,total]=jkMahal(Vector_Group,Group_Count,type);
                if total > fv
                    fv = total
                    bw = w
                end
            %end
        end
    end
end
