function cost = costf(f,penaltyf,k,xp)
costfunc = feval(f,xp);
%penaltyfunc =  k*max(0,feval(penaltyf,xp));
penaltyf1 = @(x) xp(1) + xp(2) - 2; 
penaltyf2 = @(x) xp(1) + 2*xp(2) - 3;
cost = costfunc+k*max(0,penaltyf2(xp))+k*max(0,penaltyf1(xp));
end