%David Guelph Chebyshev
clear all
clc

n = 6;
np = 2;
i = 0:1:n;
a = 0; b = 1; 
x = a + (b-a)/2*( cos( (2*i-1)*pi/(2*n)) + 1);
y = f(x);
[p,S, mu] = polyfit(x,y,np);
xx = linspace(a,b);
fp = polyval(p,xx,S,mu);

x1 = linspace(a,b);
y1 = cos(x1);
plot(x,y, '*', xx, fp,  x1, y1)
function y = f(x)
    y = cos(x);
end