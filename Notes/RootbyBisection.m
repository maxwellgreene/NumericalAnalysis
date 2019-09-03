function RootbyBisection = bisection(a, b, Tol, fp)
clear all
clc
Tol = 1e-10;
a = 0; b = 3;
fp = 2;
while abs(fp) > Tol
    fa = a^3 - 3*a - 1;
    fb = b^3 - 3*b - 1;
    p = (a+b)/2;
    fp = (p^3 - 3*p - 1);
    pd = fa*fp;
    [fa,fb,fp,pd];
    if pd>0
        a=p;
    else b=p;
        [pd,a,b];
    end
end
fprintf('%16s %9.7f \n %2s %e \n', 'Root = ', p, 'Error = ',abs(fp));
end