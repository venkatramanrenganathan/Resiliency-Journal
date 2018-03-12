%
% This function draws a plane with desired orientation.
%
% Inputs:
%           
%           - state:   [a, b, theta]
%                           (a,b): the center of the plane
%                           theta: the heading angle
%           - picSize: Size of the picture
%           - hdl    : Handle to the plot
%
% Output:
%
%           - hdl2   : Handle to the plane plot 
%
%
% (C) Kaveh Fathian, 2018.  Email: kaveh.fathian@gmail.com
%
function ha2 = DrawPlane(state, picSize, hdl, mal_flag)


%% State
x = state(1);
y = state(2);
theta = state(3);



%% Load image as persistent varibale

persistent img map alpha

% if isempty(img)  % First run   
    % The logo file(jpeg, png, etc.) must be placed in the working path
    if(mal_flag == 1)
        [imgOrig, map, alphaOrig] = imread('good.jpg');
    elseif(mal_flag == 2)
        [imgOrig, map, alphaOrig] = imread('bad.jpg');
    elseif(mal_flag == 3)
        [imgOrig, map, alphaOrig] = imread('spoof.jpg');
    end
    
    % Pad image with zeros to make it square
    sizImg = size(imgOrig);
    maxSiz = max(sizImg(1:2));
    [minSiz, minIdx] = min(sizImg(1:2));
    padSiz = round( (maxSiz - minSiz)/2 );
    padVec = [0 0 0];
    padVec(minIdx) = padSiz;
    img   = padarray(imgOrig,padVec,'both');
    alpha = padarray(alphaOrig,padVec,'both');
% end


%% Show image on figure as logo
% Source code: 
% https://www.mathworks.com/matlabcentral/answers/102646-how-do-i-add-a-logo-image-into-a-plot-or-a-figure


% GET handle to current axes and move the plot axes to the bottom
ha = hdl;
uistack(ha,'bottom');

% Creating a new axes for the logo on the current axes
ha2 = axes('position',[0 0 0.1 0.1]);

% Adding a LOGO to the new axes
im = image(ha2, img);
set(im,'AlphaData', alpha);
% colormap (map)  % Setting the colormap to the colormap of the imported logo image

% Turn the handlevisibility off so that we don't inadvertently plot
% into the axes again. Also, make the axes invisible
set(ha2, 'handlevisibility','off','visible','off')  



%%

% Desired picture
picCenter = [x y];
% picSize   = [1 1];
picAngle  = rad2deg(theta);   % Bring angle to degrees

% Adjust picture for plotting
picScale  = abs(sind(picAngle)) + abs(cosd(picAngle));
picSize   = picSize * picScale;
picCorner = picCenter - picSize./2;

% Main axis properties
axXLim   = ha.XLim;
axYLim   = ha.YLim;
axCorner = [axXLim(1),  axYLim(1)];
axSize   = [diff(axXLim), diff(axYLim)];

% Figure properties
haPos = get(ha,'position');
figCorner = haPos(1:2);
figSize   = haPos(3:4);

% Find desired second axis location
ax2Corner = figCorner + (picCorner-axCorner) .* (figSize ./ axSize);
ax2Size   = picSize .* (figSize ./ axSize);

set(ha2,'position',[ax2Corner,ax2Size]); % Set corner and size of second axis
set(ha2, 'View', [-picAngle, 90]);       % Rotate second axis

y_limit=get(gca,'ylim'); 
x_limit=get(gca,'xlim'); 
text(x_limit(1)+10, mean(y_limit), 'Safe', 'FontSize', 21);
text(65, mean(y_limit), 'Unsafe', 'FontSize', 21);
plot([x_limit(1) x_limit(1)],y_limit)
plot([50 50],y_limit) 
plot([x_limit(2) x_limit(2)],y_limit)
h1 = fill([x_limit(1) x_limit(1) 50 50], [y_limit fliplr(y_limit)], 'b','EdgeColor','none');
set(h1,'facealpha',0.01);
h2 = fill([x_limit(2) x_limit(2) 50 50], [y_limit fliplr(y_limit)], 'r','EdgeColor','none');
set(h2,'facealpha',0.01);


end