function PolynomialFit()

%Fit a 10th degree polynomial to fit f(x) = 1/(x^2+1) on th einterval
%[-3,3] using 10 intervals.
a = -3; b = 3; 
numbofint = 50; %number of intervals
ndiv = numbofint + 1; %number of points to fit
degpoly = 25; %degree of polynomial
numbofxtoplotf = 30; 


x = linspace(a,b,ndiv);
y = 1./(1+25*x.^2);
%Use polyfit to fit a 7th-degree polynomial to the points.
p = polyfit(x,y,degpoly);
%Evaluate the polynomial on a finer grid and plot the results.
x1 = linspace(a,b,numbofint);
y1 = polyval(p,x1);

%%Below is for a nice depiction of the polynomial with more points.
x2 = linspace(a,b);
y2 = polyval(p,x2);

%for smooth plot of f use more points
xx = linspace(a,b,numbofxtoplotf);
yy = 1./(1+25*xx.^2);
figure
plot(xx,yy,'-o', x1, y1, '*', x2, y2)
legend('f', 'Pn')
end