clear all; close all; clc;
load('data.mat')

% Plot parameters
plotParam.adj = adj;
plotParam.N = n;
plotParam.stateMat = stateMat;

MoviePlane(plotParam)






