function [f,xVal] = Newton(fun,tol,xVal)

f = double(fun(xVal));
syms x;
syms func(x);
syms deriv(x);
func = fun
deriv = diff(func,x)
    while (abs(f) > tol)
        xVal = xVal - func(xVal) / double(deriv(xVal))
        %disp(temp);
        %disp(temp(20));
        %disp(func(xVal));
        %disp("ayy lmao");
        f = double(func(xVal))
    end

end
