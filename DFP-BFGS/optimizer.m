% f: cost function
% x0: initial point
% maxIteration: allowed iteration number
% tol: tolerance -> abs(x_min-x*)
%% STEP 1: Function Definition -> input is vector
f = @(x) x(1).^4/4 + x(2).^2/2 - x(1).*x(2) + x(1)- x(2);
x0 = [3;5];
tol = 1e-5;
method = 'DFP';

%% STEP 1.1: OPTIONAL, Contour Plot of Function

f_plot = @(x1,x2) x1.^4/4 + x2.^2/2 - x1.*x2 + x1 - x2;

% Plotting options, xlim,ylim,resolution
upperLimit = 5;
lowerLimit = -5;
resolution = 0.01;

% Contour values
v = [-0.72,-0.5,-0.2,0.5,2]';

contourPlot(f_plot,upperLimit,lowerLimit,resolution,v);
%% STEP 2: INITIALIZE 
it = 1;
xn = x0; %x_(k+1) 
xp = x0; %x_(k)
maxIteration = 100;
while (it<maxIteration)
    % STEP 2.1 FINDING SEARCH DIRECTION
    
    % NEWTON'S METHOD
    if strcmp(method,'NewtonsMethod')
        gradientF = grad(f,xn);
        hessianF = hessfunc(f,xn);
        d = linsolve(hessianF,gradientF);
        
    % STEEPEST DESCENT
    elseif strcmp(method,'SteepestDescent')
        d = grad(f,xn); 
        
    % PARALLEL TANGENTS
    elseif strcmp(method,'ParallelTangents')
        if it==1
            d = grad(f,xp);
            temp = xp;
        elseif mod(it,2)==0 
            d = grad(f,xp);
        elseif mod(it,2)==1
            d = xp-temp;
            temp = xp;
        end
    
    % CONJUGATE GRADIENT 
    elseif strcmp(method,'conjGradient')
        if it == 1
            d = grad(f,xn);
            dp = d; %Previous direction
        else
            df = grad(f,xn);
            d = df+norm(df)^2/norm(dp)^2*dp;
            dp = d; %Previous direction
        end
    
    % DAVIDON - FLETCHER - POWELL 
    elseif strcmp(method,'DFP')
        if it == 1
            gradOld = grad(f,x0);
            q = gradOld;
            inverseHessian = eye(2);
            p = inverseHessian*gradOld;
            d = inverseHessian*gradOld;
        else
            d = inverseHessian*gradOld;
        end
     
    % BROYDEN - FLETCHER - GOLDFARB - SHANNO    
    elseif strcmp(method, 'BFGS')    
        if it == 1
            B = eye(2);
            gradOld = grad(f,x0);
            d = B*gradOld;
            d = d/norm(d);
        else
            gradOld = grad(f,xn);
            d = B*gradOld;
            d = d/norm(d);
        end
        
    else    
    end
    
    % STEP 2.2 FINDING UI
    maxItForSearch = 1000;
    [y,~, ~, ~] = searchUI(f,xp,-d,maxItForSearch);
    falpha = @(alpha)(feval(f,xp-alpha*d));
    
    % STEP 2.3 LINE SEARCH 
    fnumber = 100;
    alpha = goldenSearchWithFeval(falpha,0,y,fnumber);
    xn = xp - alpha*d;
    relativeError = norm(xn-xp);
    
    if strcmp(method,'DFP')
        %% HESSIAN APPROXIMATION UPDATE
        inverseHessian = inverseHessian + (p*p')/(p'*p)+-(inverseHessian*(q*q')*inverseHessian)/(q'*inverseHessian*q);
        gradNew = grad(f,xn);
        q = gradNew-gradOld;
        p = xn-xp;
        gradOld=gradNew;
    end

    if strcmp(method,'BFGS')
        %% HESSIAN APPROXIMATION UPDATE
        gradNew = grad(f,xn);
        q = gradNew-gradOld;
        p = xn-xp;
        B = B+(1+(q'*B*q)/(p'*q))*((p*p')/(p'*q))...
        -((p*q'*B)/(p'*q))-((B*q*p')/(p'*q));
    end
    
    %STEP 3: CHECK RELATIVE ERROR
    if relativeError < tol
        x_min = xn;
        fprintf('Iteration No: %f x_star = [%f; %f] \n', it,xn);
        return
    end
    hold on;
    plot([xn(1),xp(1)],[xn(2),xp(2)],'LineWidth',2,'Color','k');
    xp = xn;
    it = it + 1;
    fprintf('Iteration No: %f x_star = [%f; %f] \n', it,xn);
end
