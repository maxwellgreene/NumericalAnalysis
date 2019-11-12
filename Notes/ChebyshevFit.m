
function ChebyshevFit()
n = 50;
np = 50;
i = 0:1:n;
a = -3; b = 3; 
x = a + (b-a)/2*( cos( (2*i-1)*pi/(2*n)) + 1);
y = 1./(1+ 25*x.^2);
%[x; y]'
[p,S, mu] = polyfit(x,y,np);
xx = linspace(a,b);
fp = polyval(p,xx,S,mu);

x1 = linspace(a,b);
y1 = 1./(1+ 25*x1.^2);
plot(x,y, '*', xx, fp,  x1, y1)
end