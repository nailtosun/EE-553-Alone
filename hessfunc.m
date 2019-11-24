function hessf = hessfunc(f,x0)
% f: function to take gradient
% x0: point
% hessf: gradient of f at point x0
x0 = x0';
numberOfInputs = length(x0);
x = sym('x', [1 numberOfInputs]);
hessi = hessian(f(x),x);
hessf =double(subs(hessi,x,x0));
end
