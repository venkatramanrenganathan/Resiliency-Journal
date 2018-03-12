% Venkatraman Renganathan
% W_MSR Code
% Input initial conditions of node values
% See the consensus converging despite having F malicious nodes
clear all; close all; clc;
N = 8;
a = 0;
b = 100;
x0 = (b-a).*rand(N,1) + a;
y0 = (b-a).*rand(N,1) + a;
x0(4) = 20;
y0(4) = 20;
time_span = 50;
x = zeros(N, time_span+1);
y = zeros(N, time_span+1);
x(:,1) = x0;
y(:,1) = y0;
figure;
hold on;
for times = 1:time_span
    x(:,times+1) = spoofing_wmsr(x(:,times));
    y(:,times+1) = spoofing_wmsr(y(:,times));
end

plot(x',y','-','LineWidth',2,'MarkerEdgeColor','k','MarkerFaceColor',[.49 1 .63],'MarkerSize',10)
title('Resiliency in Rendezvous Using W-MSR Fails with Malicious Node Spoofing 1 more node');
xlabel('X Position');
ylabel('Y Position');
legend('Agent 1','Agent 2','Agent 3','Agent 4(Mal)','Agent 5','Agent 6','Agent 7','Agent 8(Spoof)');
a = findobj(gcf, 'type', 'axes');
h = findobj(gcf, 'type', 'line');
set(h, 'linewidth', 4);
set(a, 'linewidth', 4);
set(a, 'FontSize', 24);
