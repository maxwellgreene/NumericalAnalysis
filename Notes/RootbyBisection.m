function p = bisection(a, b, Tol, fp)
Tol = 1e-10;
a = 0; b = 3; p = (a+b)/2;
while abs(f(p)) > Tol
    p = (a+b)/2;
    if f(a)*f(p)>0
        a=p;
    else
        b=p;
    end
end
fprintf('%16s %9.7f \n %2s %e \n', 'Root = ', p, 'Error = ',abs(f(p)));
end

function f = f(x)
    f = x^3-3*x-1;
end