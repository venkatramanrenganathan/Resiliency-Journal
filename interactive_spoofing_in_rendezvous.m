% Venkatraman Renganathan
% W_MSR Code
% Input initial conditions of node values
% See the consensus converging despite having F malicious nodes
clear all; close all; clc;
N = 8;
a = 0;
b = 50;
x0 = (b-a).*rand(N,1) + a;
y0 = (b-a).*rand(N,1) + a;
theta_0 = (2*pi).*rand(N,1);
x0(4) = 20;
y0(4) = 20;
x0(8) = 15;
y0(8) = 15;
time_span = 50;
x = zeros(N, time_span+1);
y = zeros(N, time_span+1);
theta = zeros(N, time_span+1);
x(:,1) = x0;
y(:,1) = y0;
theta(:,1) = theta_0;
for times = 1:time_span
    x(:,times+1) = spoofing_wmsr(x(:,times));
    y(:,times+1) = spoofing_wmsr(y(:,times));
    x(4,times+1) = x(4,times) + 1; 
    y(4,times+1) = 20;
    x(8,times+1) = x(8,times) + 1; 
    y(8,times+1) = 15;
    theta(:,times+1) = atan2(y(:,times+1) - y(:,times), x(:,times+1) - x(:,times));
end

% Plot parameters
A = [0 1 1 0 0 0 0 0
     1 0 1 1 0 0 0 1 
     1 1 0 1 1 0 0 1
     0 1 1 0 1 1 0 0
     0 0 1 1 0 1 1 1 
     0 0 0 1 1 0 1 1
     0 0 0 0 1 1 0 0
     0 1 1 0 1 1 0 0];
plotParam.adj = A;     
plotParam.N = N;
plotParam.x = x';
plotParam.y = y';
plotParam.theta = theta';
MoviePlane(plotParam)