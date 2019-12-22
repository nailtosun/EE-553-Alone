function [] = contourPlot(f,upperLimit,lowerLimit,resolution,v)

[x1 x2] = meshgrid(lowerLimit:resolution:upperLimit);

fValues = f(x1,x2);

[C,h] = contourf(x1,x2,fValues,v);
clabel(C,h,v);
xlabel('x_1');ylabel('x_2');grid on; grid minor;
title('Contour plot of given function with given boundaries')

end
