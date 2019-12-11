%David Guelph Problem 9
clear all
clc

y0 = [1, -1];
a = 0; b = 2;
tspan = [a b];
[t,y] = ode23(@(t,y)odefcn(t,y), tspan, y0);
[t, y]
plot(t, y(:,1), t, y(:,2))


function dydt = odefcn(t, y)
    dydt = [3*y(1)^(1/2) - 4*y(2)
                 -8*y(1) - 3*y(2)]; 
end