%From Class in 8/24:
%
%Solve x^3-3x-1=0
%Solve int(tanx) from 0 to pi/4 
%Solve f(x)=(x-1)/(x+2), find f'(x) for 0<x<1

% Problem #1
% Solve x^3-3x-1=0

%Using Newton's method of approximations:
tolerance = 1e-20;   %Something really small, assuring our answer will be close
xGuess = 0;          %Doesn't really matter what you choose...
fValue = 0;

% Problem #2
while abs(fValue) > tolerance
    %From the equation 
    xZero = xGuess - (xGuess^3 - 3*xGuess - 1) / (3*xGuess - 3)
    
    
end