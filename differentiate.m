function [df,d2f] = differentiate(f,x0)
%[df,d2f] = differentiate(f,x0)
%   f  = function to differentiate (scalar function)
%   x0 = point where to differentiate (nx1)
%
%   df  = evaluated jacobian (nx1)
%   d2f = evaluated Hessian (nxn)

if(size(x0,2)<size(x0,1))
    x0 = x0';
end
numberOfInputs = length(x0);
x = sym('x', [1 numberOfInputs]);

jac = jacobian(f(x),x);
df = double(subs(jac,x,x0))';

hess = hessian(f(x),x);
d2f = double(subs(hess,x,x0));
end
