function Newton()

close all;
clear all
clc

tolerance = 1e-10;
xGuess = 20;
fValue = 10;

while abs(fValue) > tolerance
    xkp1 = xGuess - (xGuess^2 - 3*xGuess - 17) / (2*xGuess-3);
    fValue = xkp1^2 - 3*xkp1 - 17;
    xGuess=xkp1;
end
xkp1

n=300;
s=0;
for j = 1:n
   s = s + cos(j*pi/n)*pi/n; 
end
s

for i = 1:n-1
    x(i) = i;
    fp(i) = (sin((i+1)*pi/n)-sin(i*pi/n))*n/pi;
    gp(i) = cos(i*pi/n);
end
plot(x,fp,x,gp)