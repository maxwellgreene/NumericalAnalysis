

function BinaryDiffusionCoeffients ()
clear all
clc
   
                  
P = 1;
T = 600;
N2 = 1; H2 = 2; CH4 = 3; CO2 = 4; CO = 5; H2O = 6;

Name = ["N2", "H2", "CH4", "CO2", "CO", "H2O"]; 

%% R = [Name(No., \sigma, epsilon/k, Mass, Vc (cm^3/mole)]
R = [ N2, 3.798,  71.4, 28, 89.8, 273.15-196.0, 0, 0.00 
      H2, 2.827,  59.7,  2, 65.1, 273.15-253.0, 0, 0.00
     CH4, 3.758, 148.6, 16, 99.2  273.15-161.5, 0, 0.00
     CO2, 3.941, 195.2, 44, 93.9, 273.15- 78.5, 0, 0.00
      CO, 3.690,  91.7, 28, 93.2, 273.15-192.0, 1 ,0.11
     H2O, 2.641, 809.1, 18, 57.1, 273.15+100.0, 1,1.84];
A = 1.06036; B = 0.15610; C = 0.19300; D = 0.47635;
E = 1.03587; F = 1.52996; G = 1.76474; H = 3.89411;

 Vc = R(:,5); Vb = 0.258*Vc.^1.048;
 Tb = R(:,6);
 delta = 1.94e3*R(:,8)./(Vc.*Tb);

for J = 1:6 
for K = 1:6
    if J == K
        Diff(J,K) = 0;
    else 
    
   gA = R(J,1);    gB = R(K,1); 
M(gA) = R(J,4);  M(gB) = R(K,4);
  sigma(gA) = R(J,2); 
epsilon(gA) = R(J,3);   %%%This is e/k

  sigma(gB) = R(K,2); 
epsilon(gB) = R(K,3);   %%%This is e/k


MA(gA,gB)  = 2/(1/M(gA)+1/M(gB)); 
e(gA,gB)  = (epsilon(gA)*epsilon(gB))^(1/2);
Ts = T/e(gA,gB);
if R(J, 7) == 0 & R(K,7) == 0
Omega = A/Ts^B + C/exp(D*Ts)+E/exp(F*Ts)+G/exp(H*Ts);
else 
    deltaAB = delta(gA)*delta(gB);
    Omega = A/Ts^B + C/exp(D*Ts)+E/exp(F*Ts)+G/exp(H*Ts)+1.96*deltaAB/Ts;
end 
    
if R(J, 7) == 0 & R(K,7) == 0
sigmaA(gA,gB) = (sigma(gA) + sigma(gB))/2;
else
 sigmaA(gA,gB) = (sigma(gA)* sigma(gB))^(1/2);   
end
if R(J, 7) == 0 & R(K,7) == 0
BDiff(gA,gB) = (3.03 - (0.98/MA(gA,gB)^(1/2)))*1e-3*T^(3/2)/ ...
                            (P*MA(gA,gB)^(1/2)*sigmaA(gA,gB)^2*Omega);
else
BDiff(gA,gB) = 0.00266*T^(3/2)/P/MA(gA,gB)^(1/2)/sigmaA(gA,gB)^2/Omega;
end 
    end
end

end
BDiff
end

%   


