figure
%Plot something
% Add lines
h1 = line([2 2],[1 10]);
h2 = line([5 5],[1 10]);
% Set properties of lines
set([h1],'Color','k','LineWidth',2)
% Add a patch
patch([2 5 5 2],[1 1 10 10],'r')
% The order of the "children" of the plot determines which one appears on top.
% I need to flip it here.
set(gca,'children',flipud(get(gca,'children')))