%% Checking a multivariable function is a convex or concave or neither 
%  With calculating its hessian's eigenvalue - > defineteness checking

syms x;syms y;
f1 = x^2+2*y-10*x+5*y;
hf1 = hessian(f1,[x y]);
disp(eig(hf1));

f3 = x^2-5*y^2+2*x*y+10*x-10*y;
hf3 = hessian(f3,[x y]);
disp(eig(hf3));

f2 = x*exp(-x-y);
hf2 = hessian(f2,[x y]);
disp(eig(hf2));