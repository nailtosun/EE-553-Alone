%% penaltyf METHOD for CONSTRAINT OPTIMIZATION
% Step 1: FUNCTION DEFINITION with penaltyf
algorithm = 'goldenSearch';
f = @(x) -2*x(1) + x(2);
penaltyf = @(x) (x(2)- x(1).^2).^2;

x0 = [150 250]'; tol = 1e-9;
gradpenaltyf = grad(penaltyf,x0);

for k = logspace(1,5,10)

xp = x0;
cost = costf(f,penaltyf,k,xp);

it = 1;
xn = x0;
xp = x0;
maxIteration = 100;

while (it <= maxIteration)
    % FINDING SEARCH DIRECTION AT INITIAL POINT
    if it == 1
        d = -grad(f,xn)-k*grad(penaltyf,xn);
        dp = d;
    else
        df = -grad(f,xn)-k*grad(penaltyf,xn);
        d = df + norm(df)^2/norm(dp)^2*dp;
        dp = d;
    end

    % FINDING UI: search length which satisfy convexity
    maxItForSearch = 1000;
    [y,~, ~, ~] = searchUI(f,penaltyf,xp,d,maxItForSearch,k);
    % y is composed of two column vector where first column x0 and second 
    % column is x0+alpha*d
    falpha = @(alpha)(costf(f,penaltyf,k,xp+alpha*d));
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
        min = xn;
        fprintf('x_star = [%f %f], it = %f Penalty Factor: %f \n ',x_min(1),x_min(2),it,k);
    end
    it = it + 1;
    %disp(xn)
end
end
