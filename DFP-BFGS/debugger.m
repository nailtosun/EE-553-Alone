f = @(x) 8*exp(1-x)+7*log(x);
boundaries = [1 2];
tol = 1e-5;
%% USAGE
%% y = goldenSearch(f,xU,xL,direction,tol,plot)
tic;
x_star = goldenSearch(f,boundaries(2),boundaries(1),'min',tol,0);
toc;