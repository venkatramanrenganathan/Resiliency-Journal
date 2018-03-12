
itr = 100;                           % Length of line data
X = 1:itr;
Y = sin(X/5);
alpha = linspace(0.0, 1.0, itr);     % Line transparancy
cmap = [0.0700    0.4470    0.7410]; % Color map

% Plot loci
hold on
for j = 1 : itr-1
    plot(X(j:j+1),Y(j:j+1), ...
        'Color',cmap.^( alpha(j) ), ...
        'LineWidth',4); 
end
hold off















































