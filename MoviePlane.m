%%
% Shows a plane
%
% Based on MovieUnicycleVer2_1,  uses angele as the state 

function MoviePlane(plotParam)


adj = plotParam.adj;
N   = plotParam.N;
% state = plotParam.stateMat;
X = plotParam.x;
Y = plotParam.y;
Theta = plotParam.theta;


%% Folder to save the figure
currentFolder = pwd;
address =  strcat(currentFolder,'\SavedFigs\');


%% Parameters

trace = 25;             % Trace length of loci

% Size of agents on the plot
blobSize  = 10;
picSize   = 5*[1 1];      % Size of the plane on the plot

% Name and address of the video file
fileType = '.avi';
fullAddress = strcat(address,'Movie',fileType);

% Video settings
vid = VideoWriter(fullAddress);
vid.Quality = 100;      % A value between 0 to 100
vid.FrameRate = 20;

% x and y margins in the figure
xMargin = 4;
yMargin = 4;

% Color map:
cmap = repmat([255, 68, 0]./255, N,1);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Locus Movie

sizeFig = [10 5]; % was [5 4] before
position = [1 1, sizeFig];
figure('Units', 'inches', 'Position', position);
axis square
box on

% Start recording
open(vid);
itrTot = size(X,1);  % Number of iterations (movie frames)

% Create a blank plot
hdl = gca;
hdlPlane = gobjects(N,1); % Handle to the plane images

for itr = 1 : itrTot
    hold on
    
    if itr == 1 % To clear persistent variables
        clear DrawPlane
    end

    % Line transparancy
    alpha = linspace(0.0,0.95,trace);
    alpha = alpha(max(1,trace-itr):trace);
        
    for i = 1 : N
        % plot initial positions as circles
        if (itr ~= 1) && (itr < trace)
            scatter(X(1,i),Y(1,i),blobSize,cmap(i,:),...
                'MarkerEdgeColor',cmap(i,:).^(alpha(1)), 'LineWidth',2);
        end
    end
    
    for i = 1 : N
        % plot loci
        jMin = max(1,itr-trace);
        for j = jMin : itr-1
            plot(X(j:j+1,i),Y(j:j+1,i),...
                'Color',cmap(i,:).^(alpha(j-jMin+1)),'LineWidth',3); 
        end
    end
    
    % plot graph Adjacency at current location
    for m = 1 : N
        for n = 1 : N
            if adj(m,n)
            plot([X(itr,m),X(itr,n)],[Y(itr,m),Y(itr,n)], ...
                 'LineWidth',2,...
                 'Color', [0.4 0.4 0.4]);
            end
        end
    end
    
%     set(gca, 'XLimMode', 'auto');
%     set(gca, 'YLimMode', 'auto');    
    set(gca, 'XLim',[0 100]);
    set(gca, 'YLim', [0 75]);
    axis equal
%     xLim = get(gca,'XLim');    
%     yLim = get(gca,'YLim');    
%     set(gca, 'XLim', xLim + [-xMargin, xMargin]);
%     set(gca, 'YLim', yLim + [-yMargin, yMargin]);
    
    mal_flag = ones(N,1);
    for i = 1:N
        if(i == 4)
            mal_flag(i) = 2;
        end
        if(N > 7 && i > 7)
            mal_flag(i) = 3;
        end
    end
    
    % Plot planes 
    for i = 1 : N
        
        hdlPlane(i) = DrawPlane([X(itr,i),Y(itr,i), Theta(itr,i)], picSize, hdl, mal_flag(i));
        
        % Number agents at current locations
        strNums = strtrim(cellstr(num2str(i,'%d')));
        text(X(itr,i),Y(itr,i),strNums, ...
            'color', [0,0,0],                 ...
            'VerticalAlignment','middle',     ...
            'HorizontalAlignment','center',   ...
            'FontWeight','bold','FontSize',32,...
            'FontName'   , 'Times New Roman'     );

    end
        
    % Label
    hXLabel = xlabel('x','FontWeight','demi');
    hYLabel = ylabel('y','FontWeight','demi');
    htitle = title('Resiliency in Rendezvous Using W-MSR Protocol Against 1 Malicious Node');
    
    % Adjust Font and Axes Properties
    hAx = gca;
    set( gca                             , 'FontName'   , 'Times New Roman' );
    set([hXLabel, hYLabel]               , 'FontName'   , 'Times New Roman' );
    set([htitle]                         , 'FontName'   , 'Times New Roman' );
    set([hAx]                            , 'FontSize'   , 21                );
    set([hXLabel]                        , 'FontSize'   , 22                );
    set([hYLabel]                        , 'FontSize'   , 22                );
    set([htitle]                         , 'FontSize'   , 22                );
    set(gca                              , 'LineWidth'  , 1.5               );    
    
    hold off
    drawnow
    
    % Write video frame
    writeVideo(vid, getframe(gcf));
    
    % Clear axes
    if itr ~= itrTot(end)
        cla;
        for i = 1 : N
            cla(hdlPlane(i))
        end
    end  % Do not wipe the last frame
end

% Stop recording
close(vid);
