% Semidefinite Program to find probability bounds for RV lying outside a
% good set and inside a bad set.
% Takes in two mean and variance data.
% problem data
clear all; close all; clc;
agent_count = 8;
% mu_leg = randn(n,1); 
% mu_mal = randn(n,1); 
% mu_leg = zeros(5,1); 
% mu_mal = zeros(5,1); 
% mu_mal = [randn; zeros(agent_count-1,1)]; 
% Sigma_leg = randn(n,n);  
% Sigma_mal = randn(n,n); 
data_set = sdp_data_set(agent_count);
mu_leg = data_set.mu_leg;
mu_mal = data_set.mu_mal;
Sigma_leg = data_set.sigma_leg;
Sigma_mal = data_set.sigma_mal;
Sigma_leg = Sigma_leg'*Sigma_leg + mu_leg*mu_leg';
Sigma_mal = Sigma_mal'*Sigma_mal + mu_mal*mu_mal';
n = size(mu_leg,1); % dimensions
tol = 1e-5;
difference = 1;
alfa = 0.05;
previous_opt = 0;
c = (mu_leg - mu_mal)'*(mu_leg + (mu_leg - mu_mal)*alfa);
alfa_vec = 0.0:0.001:0.01;
optimal_values = zeros(10,1);

cvx_begin sdp
    variable Z(n,n) symmetric
    variable z(n,1)    
    variable lambda_leg
    variable lambda_mal
    % 1-lambda_1: Prob that X lies to one side of hyperplane: b'x+c <= 0
    % 1-lambda_2: Prob that X lies to other side of hyperplane: b'x+c >= 0    
    minimize ( (1 - lambda_leg) + (1 - lambda_mal))
    subject to
        [1 zeros(1,n-1)]*z - c*lambda_leg >= 0; 
        [1 zeros(1,n-1)]*z - c*lambda_mal <= 0;
        [Z z; z' lambda_leg] <= [Sigma_leg mu_leg; mu_leg' 1];
        [Z z; z' lambda_leg] >= 0;
        [Z z; z' lambda_mal] <= [Sigma_mal mu_mal; mu_mal' 1];
        [Z z; z' lambda_mal] >= 0; 
cvx_end      
    