function [sensitivity,misjudgment,mcc]=MCC(TP,TN,FP,FN)

% MCC 计算马太相关系统
% TP 实际为真，也判断为真
% FP 实际为假，但判断为真
% FN 实际为真，但判断为假
% TN 实际为假，也判断为假

%return value
%  sensitivity 敏感度
%  misjudgment 误判率
%  mcc 马太相关系数

sensitivity = TP/(TP + FN);

misjudgment = TN/(FP + TN);

mcc = (TP*TN-FP*FN)/sqrt((TP+FP)*(TP+FN)*(TN+FP)*(TN+FN));

