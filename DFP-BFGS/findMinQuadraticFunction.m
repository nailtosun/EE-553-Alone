%% Function Definition
syms x1;syms x2;
f = 2*(x2-x1^2)^2+(1-x1)^2;
%% Contour plot
fcontour(f,[-4 4 -4 6]);grid on;grid minor;

%% Search for initial x0 point
f = @(x1,x2 )2*(x2-x1^2)^2+(1-x1)^2;
x0 = [2,-2]; 
[xmin, fval] = fminsearch(@(x)f(x(1),x(2)), x0)