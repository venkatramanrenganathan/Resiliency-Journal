
% Venkatraman Renganathan
% W_MSR Code
% Input initial conditions of node values
% See the consensus converging despite having F malicious nodes
clear all; close all; clc;
N = 7;
a = 0;
b = 100;
x0 = (b-a).*rand(N,1) + a;
y0 = (b-a).*rand(N,1) + a;
x0(4) = 20;
y0(4) = 20;
time_span = 50;
x = wmsr_algorithm(time_span,x0);
y = wmsr_algorithm(time_span,y0);
plot(x',y');
title('Resiliency in Rendezvous Using W-MSR Protocol Against 1 Malicious Node');
xlabel('X Position');
ylabel('Y Position');
legend('Agent 1','Agent 2','Agent 3','Agent 4(Mal)','Agent 5','Agent 6','Agent 7');
a = findobj(gcf, 'type', 'axes');
h = findobj(gcf, 'type', 'line');
set(h, 'linewidth', 4);
set(a, 'linewidth', 4);
set(a, 'FontSize', 24);
