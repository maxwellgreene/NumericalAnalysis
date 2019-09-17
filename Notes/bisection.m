function p = bisection(f,a,b,tol)
count=0;
if f(a)*f(b)>0 
    disp('Wrong choice bro')
else
    p = (a + b)/2;
    err = abs(f(p));
   while err > tol
       count=count+1;
     if f(a)*f(p)<0 
       b = p;
     else
       a = p;          
     end
     p = (a + b)/2; 
     err = abs(f(p));
   end
    disp(count)
end