function cost = costf(f,penaltyf,k,xp)
costfunc = feval(f,xp);
barrierf1 = @(x) log10(1/x(1)); 
barrierf2 = @(x) log10(1/x(2));
penaltyfunc =  k*max(0,real(feval(barrierf1,xp)))+ k*max(0,real(feval(barrierf2,xp)));
if xp(1)<0 || xp(2)<0 
    penaltyfunc = 10^10;
end
cost = costfunc+penaltyfunc;
end