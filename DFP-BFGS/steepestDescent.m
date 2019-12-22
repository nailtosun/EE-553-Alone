%CONTANTS
maxIteration = 10000;
x = [2 ;-2];
%%
%Contour plotting of multivariable function
f = @(x1,x2) 100*(x2 - x1^2)^2 + (1 - x1^2);
figure(1)
fcontour(f,[-10 10 -40 20])
%%
syms x1;syms x2;
f = 100*(x2 - x1^2)^2 + (1 - x1^2);
fx = @(x)(100*(x(2) - x(1)^2)^2 + (1 - x(1))^2);
dfx1 = diff(f,x1);dfx2 = diff(f,x2);
gradF = @(x) [- 2*x(1) - 400*x(1)*(- x(1)^2 + x(2));- 200*x(1)^2 + 200*x(2)];
d = -gradF(x);

%%
it = 1;
while(it<maxIteration)
d = -gradF(x);
[y itL itS fCount] = searchUI(fx,x,d/100,1000);
nrow = linspace(y(1,1),y(1,2),100);
nrow2 = linspace(y(2,1),y(2,2),100);
searchPoints = [nrow ;nrow2];
% for i = 1:100
%     r(i) = fx(searchPoints(:,i));
% end
% figure(2)
% scatter(1:100,r);hold on;
x_memory(:,it)=x;
x = goldenSearchWithFeval(fx,y(:,2),y(:,1),1000);
it = it + 1;
end
% figure(1)
% for j = 1:maxIteration-2
% hold on;
% p1 = x_memory(:,j)';                         % First Point
% p2 = x_memory(:,j+1)';                         % Second Point
% dp = p2-p1;                         % Difference
% 
% quiver(p1(1),p1(2),dp(1),dp(2),0)
% grid on;
% axis([-10 10 -40 2])
% hold on;
% end