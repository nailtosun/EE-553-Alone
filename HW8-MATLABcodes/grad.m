function gradf = grad(f,x0)
% f: function to take gradient
% x0: point
% gradf: gradient of f at point x0
x0 = x0';
numberOfInputs = length(x0);
x = sym('x', [1 numberOfInputs]);
jac = jacobian(f(x),x);
gradf = double(subs(jac,x,x0))';
end
