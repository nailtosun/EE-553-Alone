function cost = costf(f,penaltyf,k,xp)
costfunc = feval(f,xp);
%penaltyfunc =  k*max(0,feval(penaltyf,xp));
penaltyf = @(x) (x(2)- x(1).^2).^2;
cost = costfunc+k*max(0,penaltyf(xp));
end