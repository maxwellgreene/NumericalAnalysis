%{
Problem #1
2X1 + 3X2 \leq 90 
3X1 + 2X2 \leq 120
P(X) = 7X1+5X2    
%}

%{
Problem #2
2X1 + 4X2 \leq 220
3X1+2X2 \leq 150
P(X) = 4X1 + 3X2
%}


%{
Problem #3

Write a program to integrate 
y''-3y'+ty = t^2+5
subject to condition 
y(0)=1, y'(0)=0
%}
function solution = HW8()

solution = 0;
a = 0; b = 1; tspan = [a b];
y0 = 1; yp0 = 0;

[t,y] = ode23s(@(t,y) odefunc(t,y,a,b) , tspan , y0);

t1 = linspace(a,b,101);

plot(t,y)
end

function dydt = odefunc(t,y,a,b)

dydt = (t.^2+5-t.*y)/(-3);

end






