clear; clc;
upperLimit = 10;
lowerLimit = 0;
resolution = 0.01;

[x1 x2] = meshgrid(lowerLimit:resolution:upperLimit);

% Objective function
f = @(x,y) -14*x + x.^2 -6*y + y.^2 - 7;

fValues = f(x1,x2);


% Contour values
v = [-65,-30,-8,0.5,10]';

[C,h] = contourf(x1,x2,fValues,v);
clabel(C,h,v);
xlabel('x_1');ylabel('x_2');grid on; grid minor;
title('Contour plot of given function with given boundaries')
