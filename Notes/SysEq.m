function SysEq ()
clear all
clc


 X = [6; 3];  
 Tol = 1e-20;
 df = 20;
 %%%%%%%%%%%%%  The real solution is x = 1 and y = 1. But do we alwasys get
 %%%%%%%%%%%%%  the true result? Well, we are up against a machine! Then do
 %%%%%%%%%%%%%  the following and see what happens. Can you explain the
 %%%%%%%%%%%%%  different results?
 alphak = 1.0;  %try this first.
%alphak = 2.0;  %try this second
%alphak = 1.9;   %try this third. See what happens to the results.
%alphak = 1.8;   %try this third. See what happens to the results.
%alphak = 1.7;   %try this third. See what happens to the results.
 while df > Tol
     XN = X - alphak*J(X)*f(X);
     df =(dot((XN-X),(XN-X)))^0.5;
     X = XN;
 end
  
 df
 X
function fgxy = f(X)
x = X(1); y = X(2);
v1 = x^2*y-3*x +2;
v2 = 2*x*y^2 + 4*y -6;
fgxy = [v1; v2];
end

function InvJak = J(X)
x = X(1); y = X(2);
Jak = [2*x*y-3, x^2
       2*y^2, 4*x*y + 4];
   InvJak = inv(Jak);
end
end