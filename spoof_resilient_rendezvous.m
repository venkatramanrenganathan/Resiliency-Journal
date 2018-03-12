% Venkatraman Renganathan
% Checking Spoof resiliency in rendezvous problem
% Input initial conditions of node values
% See the consensus converging despite having F malicious nodes and them
% spoofing any number of spoofed values.

clear all; close all; clc;
N = 8;
a = 0;
b = 100;
delay = 0;
x0 = (b-a).*rand(N,1) + a;
y0 = (b-a).*rand(N,1) + a;
x0(7) = 20;
y0(7) = 20;
x0(8) = 20;
y0(8) = 20;
time_span = 50;
x = zeros(N, time_span+1);
y = zeros(N, time_span+1);
x(:,1) = x0;
y(:,1) = y0;
delay_flag = 1;
figure;
hold on;
for times = 1:time_span
    if(times <= delay)
        delay_flag = 1;
        x(:,times+1) = spoof_resilient_wmsr(delay_flag, x(:,times));
        y(:,times+1) = spoof_resilient_wmsr(delay_flag, y(:,times));
    end    
    if(times > delay)
        if(times == delay + 1)
            % Spoofing detected & spoofed node removed from the network
            N = N - 1;
            x(8,:) = []; % Removing spoofed node from the network 
            y(8,:) = []; % Removing spoofed node from the network
        end
        delay_flag = 0;
        dummy = spoof_resilient_wmsr(delay_flag, x(:,times));
        x(:,times+1) = spoof_resilient_wmsr(delay_flag, x(:,times));
        y(:,times+1) = spoof_resilient_wmsr(delay_flag, y(:,times));
    end
    
end

plot(x',y');
title('Spoof Resilient Consensus using Spoof Resilient W-MSR Algorithm')
xlabel('X Position');
ylabel('Y Position');
legend('Agent 1','Agent 2','Agent 3','Agent 4','Agent 5','Agent 6','Agent 7(Mal)');
a = findobj(gcf, 'type', 'axes');
h = findobj(gcf, 'type', 'line');
set(h, 'linewidth', 4);
set(a, 'linewidth', 4);
set(a, 'FontSize', 24);
