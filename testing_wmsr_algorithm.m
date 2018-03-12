
% Venkatraman Renganathan
% W_MSR Code
% Input initial conditions of node values
% See the consensus converging despite having F malicious nodes
clear all; close all; clc;
x0 = [60,68,75,300,90,110,85]';
legit_x0 = [60,68,75,90,110,85]';
time_span = 40;
x = wmsr_algorithm(time_span,x0);
time_vec = 0:1:time_span;
plot(time_vec,x);
ylim([0 320]);
hold on;
plot(time_vec, mean(legit_x0)*ones(1,time_span+1), '-.r');
hold on;
Y1 = max(legit_x0)*ones(1,time_span+1);
Y2 = min(legit_x0)*ones(1,time_span+1);
plot(time_vec, Y1, '--b', time_vec, Y2, '--b');
h = fill([time_vec fliplr(time_vec)], [Y1 fliplr(Y2)], 'b');
set(h,'facealpha',0.1);
title('Standard W-MSR - Consensus Obtained with 1 Malicious Node');
xlabel('Time Steps');
ylabel('Information States');
legend('Agent 1','Agent 2','Agent 3','Agent 4(Mal)','Agent 5','Agent 6','Agent 7', 'Legitimate Mean');
a = findobj(gcf, 'type', 'axes');
h = findobj(gcf, 'type', 'line');
set(h, 'linewidth', 4);
set(a, 'linewidth', 4);
set(a, 'FontSize', 24);
