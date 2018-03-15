function [sensitivity,misjudgment,mcc]=MCC(TP,TN,FP,FN)

% MCC ������̫���ϵͳ
% TP ʵ��Ϊ�棬Ҳ�ж�Ϊ��
% FP ʵ��Ϊ�٣����ж�Ϊ��
% FN ʵ��Ϊ�棬���ж�Ϊ��
% TN ʵ��Ϊ�٣�Ҳ�ж�Ϊ��

%return value
%  sensitivity ���ж�
%  misjudgment ������
%  mcc ��̫���ϵ��

sensitivity = TP/(TP + FN);

misjudgment = TN/(FP + TN);

mcc = (TP*TN-FP*FN)/sqrt((TP+FP)*(TP+FN)*(TN+FP)*(TN+FN));

