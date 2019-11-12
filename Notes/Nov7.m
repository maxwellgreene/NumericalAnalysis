%%Solve dy/dt = y + t^2 - 1, y(0) = 1, 0 <= t <= 1

a = 1; b = 2;

tspan = [a b];
y0 = [2, 8, 6];
[t,y] = ode23(@(t,y) odefcn(t,y), tspan, y0);
t1 = linspace(a,b);
f = 2.*t1 - 1./t1 + t1.^2 + t1.^3 - 1;
plot(t, y(:,1), t1, f)
hold off

function dydt = odefcn(t, y)
dydt = [y(2)
        y(3)
        -1/t*y(3)+2/t^2*y(2)-2/t^3*y(1) + 8 - 2/t^3];
end

