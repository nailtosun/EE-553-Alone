%% Function definition with x = [x1;x2]
f = @(x) (x(2)-x(1)^2)^2+(1-x(1))^2;
%% In?tial Point x0 - > column vector
x0 = [2; -2];
%% Newton's Method with Different 1-D Search Algorithm

x_star = newtonsMethod(f,x0,10,1e-10,'goldenSearch');
disp('x* is following: (Newtons Method with Golden Search)')
disp(x_star);
toc;

tic;
x_star = newtonsMethod(f,x0,10,1e-5,'fibonacciSearch');
disp('x* is following: (Newtons Method with Fibonacci Search)')
disp(x_star);
toc;

tic;
x_star = newtonsMethod(f,x0,10,1e-5,'dichotomousSearch');
disp('x* is following: (Newtons Method with Dichotomous Search)')
disp(x_star);
toc;

tic;
x_star = newtonsMethod(f,x0,10,1e-5,'quadraticSearch');
disp('x* is following: (Newtons Method with Quadratic Interpolation)')
disp(x_star);
toc;
%% Steepest Descent with Different 1-D Search Algorithm

x_star = steepestDescent2(f,x0,1000,1e-10,'goldenSearch');
disp('x* is following: (Steepest Descent with Golden Search)')
disp(x_star);
toc;

tic;
x_star = steepestDescent2(f,x0,1000,1e-5,'fibonacciSearch');
disp('x* is following: (Steepest Descent with Fibonacci Search)')
disp(x_star);
toc;

tic;
x_star = steepestDescent2(f,x0,1000,1e-5,'dichotomousSearch');
disp('x* is following: (Steepest Descent with Dichotomous Search)')
disp(x_star);
toc;

tic;
x_star = steepestDescent2(f,x0,1000,1e-5,'quadraticSearch');
disp('x* is following: (Steepest Descent with Quadratic Interpolation)')
disp(x_star);
toc;
%% Method of Parallel lines
tic;
x_star = parallelTangents(f,x0,1000,1e-10,'goldenSearch');
disp('x* is following: (Parallel Tangents with Golden Search)')
disp(x_star);
toc;

tic;
x_star = parallelTangents(f,x0,1000,1e-5,'fibonacciSearch');
disp('x* is following: (Parallel Tangents with Fibonacci Search)')
disp(x_star);
toc;

tic;
x_star = parallelTangents(f,x0,1000,1e-5,'dichotomousSearch');
disp('x* is following: (Parallel Tangents with Dichotomous Search)')
disp(x_star);
toc;

tic;
x_star = parallelTangents(f,x0,1000,1e-5,'quadraticSearch');
disp('x* is following: (Parallel Tangents with Quadratic Interpolation)')
disp(x_star);
toc;
%%
tic;
x_star = conjGradient(f,x0,1000,1e-10,'goldenSearch');
disp('x* is following: (Conjugate Gradient with Golden Search)')
disp(x_star);
toc;

tic;
x_star = conjGradient(f,x0,1000,1e-5,'fibonacciSearch');
disp('x* is following: (Conjugate Gradient with Fibonacci Search)')
disp(x_star);
toc;

tic;
x_star = conjGradient(f,x0,1000,1e-5,'dichotomousSearch');
disp('x* is following: (Conjugate Gradient with Dichotomous Search)')
disp(x_star);
toc;

tic;
x_star = conjGradient(f,x0,1000,1e-5,'quadraticSearch');
disp('x* is following: (Conjugate Gradient with Quadratic Interpolation)')
disp(x_star);
toc;