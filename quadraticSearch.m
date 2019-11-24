function y = quadraticSearch(f,xL,xU,it,tol)
% initial Guess
x1 = xL; x2 = (xL+xU)/2; x3 = xU; x = [x1 x2 x3 0];
for i= 1:it
   
    if i==1
         f1 = feval(f,x(1)); %Biggest
         f2 = feval(f,x(2)); %Minimum
         f3 = feval(f,x(3)); %Mid one
    else
         f1 = feval(f,x(2)); 
         f2 = feval(f,x(1)); 
         f3 = feval(f,x(3));
         %swap
         temp1 = x(1);
         x(1) = x(2);
         x(2) = temp1;
         
    end
    
    N = feval(f,x(1))*(x(2)^2-x(3)^2)+feval(f,x(2))*(x(3)^2-x(1)^2)+ feval(f,x(3))*(x(1)^2-x(2)^2);
    D = 2*feval(f,x(1))*(x(2)-x(3))+2*feval(f,x(2))*(x(3)-x(1))+ 2*feval(f,x(3))*(x(1)-x(2));
    x(4) = N/D;
    f4 = feval(f,x(4)); % New minimum
    A=[f1 f2 f3 f4];
    [out,idx] = sort(A,'ascend');
    x = [x(idx(4)) x(idx(3)) x(idx(2)) x(idx(1))];   
    x_minCandidate(i+1) = x(4);
    relativeError = abs(x_minCandidate(i+1)-x_minCandidate(i));
    if relativeError < tol
        %disp('x* is following');
        y = x(4);
        break;
    else
        %disp(x(4));
    end
    
end
y = x(4);
end