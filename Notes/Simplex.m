
A = [2, 1;  1, 1,;1, 0];
b = [75; 60; 25];
lb = [0,0];
f = [150; 100];

[x, fval] = linprog(-f, A, b, [],[],lb);

y = A\b;
opt = dot(y, f);


%{
Problem #1
2X1 + 3X2 \leq 90 
3X1 + 2X2 \leq 120
P(X) = 7X1+5X2    

Problem #2
2X1 + 4X2 \leq 220
3X1+2X2 \leq 150
P(X) = 4X1 + 3X2

Write a program to integrate 
y''-3y'+ty = t^2+5
subject to condition 
y(0)=1, y'(0)=0
%}

