function def(x,y,r,d)
hold on
th = 0:pi/50:2*pi;
k = r-1.2;
while k>r-d
xunit1 = (k) * cos(th) + x;
yunit1 = (k) * sin(th) + y;
plot(xunit1, yunit1,'w');
k = k - 0.1;
end
set(gca,'Color','k');
daspect([1 1 1]);
hold off