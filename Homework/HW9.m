%Loading Experimental Data
load('FirstDataSet')
data = FirstDataSet;
tx = data(:,1);
yx = data(:,2);

%Experimental Data Plot
plot(tx,yx);

%Simulated Data Calculations
%Solve y'' + cy' - y = t*exp(-dt), 0<=t<=1
%With initial conditions

optFunc = @(input) errorFunction(input(1),input(2));

min = optimize(optFunc,[0,0]);


a = 0; b = 1;
c = min(1); d = min(2);
y0 = [0, 1];

[t,y] = ode23s(@(t,y) odefunc(t,y,c,d) , tx , y0);

plot(tx,yx,t,y(:,1));

optFunc = @(input) errorFunction(input(1),input(2));

min = optimize(optFunc,[8,1.25]);
min

function dydt = odefunc(t,z,c,d)
dydt = [z(2)
        -c*z(2)+z(1)+t*exp(-d*t)];
end

function [a,b] = optimize(optfunc,params)
[a,b] = fminsearch(optfunc,[params(1),params(2)]);
end

function error = errorFunction(a1,a2)
load('FirstDataSet.mat');
data = FirstDataSet;
tx = data(:,1); yx = data(:,2);
a = 0;  b = 1; c = a1; d = a2;
[t,y] = ode23s(@(t,y) odefunc(t,y,c,d) , tx , [0,1]);
error = sum((y(:,1)-yx).^2);
end




