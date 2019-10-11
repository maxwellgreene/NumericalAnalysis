function [p,count] = RootbyBisection(a, b, Tol, f)
p = (a+b)/2;
count=0;
while abs(f(p)) > Tol
    p = (a+b)/2;
    if f(a)*f(p)>0
        a=p;
    else
        b=p;
    end
    count = count + 1;
end

end