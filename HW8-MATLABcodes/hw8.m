%% QUESTION 10
% Contour plot of function -f and its constraints
clear; clc;
upperLimit = 10;
lowerLimit = -5;
resolution = 0.01;

[x1 x2] = meshgrid(lowerLimit:resolution:upperLimit);

% Objective function
f = @(x,y) -14*x + x.^2 -6*y + y.^2 - 7;

fValues = f(x1,x2);

penaltyf1 = @(x) - x + 2; 
penaltyf2 = @(x) -0.5*x  + 3/2;
% Contour values
v = [-65,-30,-8,0.5,10]';

[C,h] = contourf(x1,x2,fValues,v);
clabel(C,h,v);
xlabel('x_1');ylabel('x_2');grid on; grid minor;
title('Contour plot of given function with given boundaries')
hold on;
fplot( penaltyf1, [-5 5] ,'LineWidth',3)
fplot( penaltyf2, [-5 5] ,'LineWidth',3)

%% ALGORITHM
% Chosing the line search algoritm
algorithm = 'goldenSearch';

% Minimize that function
f = @(x) -14*x(1) + x(1).^2 -6*x(2) + x(2).^2 - 7;
penaltyf1 = @(x) x(1) + x(2) - 2; 
penaltyf2 = @(x) x(1) + 2*x(2) - 3;

x0 = [10 10]'; tol = 1e-9;
for k = logspace(-5,10,20)

xp = x0;
cost = costf(f,penaltyf1,k,xp);

it = 1;
xn = x0;
xp = x0;
maxIteration = 100;

while (it <= maxIteration)
    % FINDING SEARCH DIRECTION AT INITIAL POINT
    if it == 1
        d = -grad(f,xn)-k*grad(penaltyf1,xn)-k*grad(penaltyf2,xn);
        dp = d;
    else
        df = -grad(f,xn)-k*grad(penaltyf1,xn)-k*grad(penaltyf2,xn);
        d = df + norm(df)^2/norm(dp)^2*dp;
        dp = d;
    end

    % FINDING UI: search length which satisfy convexity
    maxItForSearch = 1000;
    [y,~, ~, ~] = searchUI(f,penaltyf1,xp,d,maxItForSearch,k);
    % y is composed of two column vector where first column x0 and second 
    % column is x0+alpha*d
    falpha = @(alpha)(costf(f,penaltyf1,k,xp+alpha*d));
    % LINE SEARCH
    fnumber = 1000;
    if strcmp(algorithm ,'goldenSearch')
        alpha = goldenSearchWithFevalPenalty(falpha,0,y,fnumber);
        xn = xp + alpha*d;
    elseif strcmp(algorithm , 'dichotomousSearch')
        alpha = dichotomousWithFeval(falpha,fnumber,0,y);
        xn = xp + alpha*d;
    elseif strcmp(algorithm , 'quadraticSearch')
        alpha = quadraticSearch(falpha,0,y,fnumber,1e-5);
        xn = xp + alpha*d;
    elseif strcmp(algorithm , 'fibonacciSearch')
        alpha = fibonacciSearch(falpha,0,y,y/10000,0);
        xn = xp + alpha*d;
    elseif strcmp(algorithm , 'secant')
        disp('GG');
        break
    elseif strcmp(algorithm , 'newton')
        disp('GG');
        break
    else
        disp('GG');
        break
    end
    
    if norm(xn-xp)<tol
        x_min = xn;
        fprintf('x_star = [%f %f], it = %f Penalty Factor: %f \n ',x_min(1),x_min(2),it,k);
        it = maxIteration + 10;
    end
    
    xp = xn;
    if it == maxIteration
        x_min = xn;
        fprintf('x_star = [%f %f], it = %f Penalty Factor: %f \n ',x_min(1),x_min(2),it,k);
    end
    it = it + 1;
    %disp(xn)
end
end
%%
hold on;
scatter(x_min(1),x_min(2),100,'k','LineWidth',4)

%% NOTES
% When we look at the results I saw that when penalty values are low (<<1)
% the result converge the unconstraint problem's result. However, when we
% increase the penalty value towards infinity we saw that the new optimum
% point goes to global minima at boundary of constraint. Since the original
% question is finding maximum of f, we manipulate the optimization
% algorithm to find minimum of f. 