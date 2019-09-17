function f = finalpoint(func)
x0 = 1;
x1=0;
tol = 1e-10;
dx = 10;
while dx > tol
    x1 = func(x0);
    dx = abs(x1-x0);
    x0=x1;
end
disp(x0);
end