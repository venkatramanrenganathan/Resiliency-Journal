y1=[.61 .52 .45 .75 .76 .79 .82 .6 .66 .54 .43 .21];
N=size(y1,2);
sky_blue = [0, 0, 1] ;
x=1:N;           
plot([1:N]', y1, 'linewidth', 2.8, 'linestyle', '-', 'color', sky_blue);
hold on
x1=7;
x2=8;
y2=get(gca,'ylim');    
plot([x1 x1],y2)
plot([x2 x2],y2)    
h1 = fill([x1 x1 x2 x2], [y2 fliplr(y2)], 'b','EdgeColor','none');
set(h1,'facealpha',0.1);