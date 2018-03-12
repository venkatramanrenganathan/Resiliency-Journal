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
x = zeros(N, time_span+1);
y = zeros(N, time_span+1);
x(:,1) = x0;
y(:,1) = y0;
marker = imread('car.png');
markersize = [1,1];
alpha = linspace(0.0, 1.0, time_span);     % Line transparancy
%cmap = [0.0700    0.4470    0.7410]; % Color map
%cmap = [0.2 0.0 1.0];
cmap = rand(N,3);
figure;
hold on;
for times = 1:time_span
    x(:,times+1) = wmsr_rendezvous(x(:,times));
    y(:,times+1) = wmsr_rendezvous(y(:,times));
%     plot_x = x(:,times+1);
%     plot_y = y(:,times+1);
%     for i = 1:N
%         plot(x(i,times:times+1)',y(i,times:times+1)', 'Color',cmap(i,:).^( alpha(times) ), 'LineWidth',4); 
%     end
end

plot(x',y','-','LineWidth',2,'MarkerEdgeColor','k','MarkerFaceColor',[.49 1 .63],'MarkerSize',10)
title('Resiliency in Rendezvous Using W-MSR Protocol Against 1 Malicious Node');
xlabel('X Position');
ylabel('Y Position');
legend('Agent 1','Agent 2','Agent 3','Agent 4(Mal)','Agent 5','Agent 6','Agent 7');
a = findobj(gcf, 'type', 'axes');
h = findobj(gcf, 'type', 'line');
set(h, 'linewidth', 4);
set(a, 'linewidth', 4);
set(a, 'FontSize', 24);
