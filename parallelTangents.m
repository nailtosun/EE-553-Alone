function x_min = parallelTangents(f,x0,maxIteration,tol,algorithm)
% f: cost function
% x0: initial point
% maxIteration: allowed iteration number
% tol: tolerance -> abs(x_min-x*)
it = 1;
xn = x0;
xp = x0;
while (it <= maxIteration)
    % FINDING SEARCH DIRECTION AT INITIAL POINT
   
    if(it==1)
        d = -grad(f,xp);
        temp = xp;
    elseif(mod(it,2)==0)
        d = -grad(f,xp);
    elseif(mod(it,2)==1)
        d = xp-temp;
        temp = xp;
    end
 
    % FINDING UI: search length which satisfy convexity
    maxItForSearch = 1000;
    [y,~, ~, ~] = searchUI(f,xp,d,maxItForSearch);
    % y is composed of two column vector where first column x0 and second 
    % column is x0+alpha*d
    falpha = @(alpha)(feval(f,xp+alpha*d));
    % LINE SEARCH
    fnumber = 1000;
    if strcmp(algorithm ,'goldenSearch')
        alpha = goldenSearchWithFeval(falpha,0,y,fnumber);
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
    asd = norm(xn-xp);
    if xn == xp
        x_min = xn;
        return
    end
    
    xp = xn;
    
    it = it + 1;
    %disp(xn)
end
x_min = xn;
end