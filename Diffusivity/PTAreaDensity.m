function PTAreaDensity()
%This program caomptes the effective diffusivities for one pressure, one
%temperature, one area and one density. 

prompt  = 'Enter  pressure (Pascal)    \n';
P = input(prompt)/100000;
prompt  = 'Enter  temperature (^C)    \n';
T = input(prompt)+273.15;
prompt  = 'Enter  catalyst area (sq. m)    \n';
S = input(prompt)*1e4;
prompt  = 'Enter  catalyst particle denstiy (g/cm^3)    \n';
rhos = input(prompt)

pCH4 = 0.0*P; pCO2 = 0.0*P;
pCO  = 0.2*P;  pH2 =  0.6*P; pH2O = 0.0*P;
pin(1) = pCH4; pin(2) = pCO2;
pin(3) = pCO; pin(4) =  pH2; pin(5) = pH2O; 
[DeffCH4, DeffCO2, DeffCO, DeffH2O, DeffH2] = ...
                      EffDiffusionfCoeff(P, T, pin, S, rhos);
[DeffCH4; DeffCO2; DeffCO; DeffH2O; DeffH2]'
end

function [D1, D2, D3, D4, D5] = EffDiffusionfCoeff(P, T,pin, S, rhos)
Ne = 1; H2 = 2; CH4 = 3; CO2 = 4; CO = 5; H2O = 6;
pCH4 = pin(1); pCO2 = pin(2); pCO = pin(3);  pH2 =  pin(4); pH2O = pin(5);
numComps = input('How many components? \n');

Names = ["Ne", "H2", "CH4", "CO2", "CO", "H2O"];
data = readtable('data2.txt');
tableVals = [5];
tempR = zeros([1,length(Names)]);

for i = (1:length(Names))
    rowNums = (data.Var1 == Names(i));
    tempR(i) = table2array(data(rowNums,tableVals));%[Names(i),data(rowNums,tableVals)];
end

R = horzcat((1:length(tempR))',tempR');


% R = [ Ne, 2.820,  32.8, 20
%       H2, 2.827,  59.7,  2
%      CH4, 3.758, 148.6, 16
%      CO2, 3.941, 195.2, 44
%       CO, 3.690,  91.7, 28
%      H2O, 2.641, 809.1, 18];
%disp(type(R))
%disp(type(R(1,1)))
 
A = 1.06036; B = 0.15610; C = 0.19300; D = 0.47635;
E = 1.03587; F = 1.52996; G = 1.76474; H = 3.89411;

for J = 1:numComps
for K = 1:numComps
    if J == K
        DIff(J,K) = 0;
    else 
        
   gA = R(J,1);    gB = R(K,1);
M(gA) = R(J,4);  M(gB) = R(K,4);
sigma(gA) = R(J,2); epsilon(gA) = R(J,3);   %%%This is e/k
sigma(gB) = R(K,2); epsilon(gB) = R(K,3);   %%%This is e/k
M(gA,gB)  = 2/(1/M(gA)+1/M(gB)); 
e(gA,gB)  = (epsilon(gA)*epsilon(gB))^(1/2);

Ts = T/e(gA,gB);
Omega = A/Ts^B + C/exp(D*Ts)+E/exp(F*Ts)+G/exp(H*Ts);

sigma(gA,gB) = (sigma(gA) + sigma(gB))/2;
%BDiff(gA,gB) = 0.00266*T^(3/2)/P/M(gA,gB)^(1/2)/sigma(gA,gB)^2/Omega;
BDiff(gA,gB) = (3.03 - (0.98/M(gA,gB)^(1/2)))*1e-3*T^(3/2)/ ...
                             (P*M(gA,gB)^(1/2)*sigma(gA,gB)^2*Omega);
%%% Wilke and Lee P 587
end 
end
end

%    function DCoH2O = BinDiffPolar
  muCO = 0.11; muH2O = 1.84;
  MCO = 28; MH2O = 18;
VbCO = 35.31; VbH2O = 18.80;
TbCO = 81.63; TbH2O = 373.15;
deltaCO = 1.94e3*muCO^2/VbCO/TbCO;
deltaH2O = 1.94e3*muH2O^2/VbH2O/TbH2O;
deltaCOH2O = (deltaCO*deltaH2O)^(1/2);
sigmaCO = ((1.585*VbCO)/(1+1.3*deltaCO^2))^(1/3); 
epsilonCO = 1.18*(2+1.3*deltaCO^2)*TbCO;  
sigmaH2O = ((1.585*VbH2O)/(1+1.3*deltaH2O^2))^(1/3);
epsilonH2O = 1.18*(2+1.3*deltaH2O^2)*TbH2O;
MCOH2O = 2/(1/MCO+1/MH2O);
eCOH2O = (epsilonCO*epsilonH2O)^(1/2);
Ts = T/eCOH2O;
sigmaCOH2O = (sigmaCO + sigmaH2O)/2;
Omega = A/Ts^B + C/exp(D*Ts)+E/exp(F*Ts)+G/exp(H*Ts)+0.19*deltaCOH2O^2/Ts;
%BDiff(CO,H2O) = 0.00266*T^(3/2)/P/MCOH2O^(1/2)/sigmaCOH2O^2/Omega;
BDiff(gA,gB) = (3.03 - (0.98/M(gA,gB)^(1/2))*1e-3*T^(3/2))/ ...
                             (P*MCOH2O^(1/2)*sigmaCOH2O^2*Omega);
BDiff(H2O,CO) = BDiff(CO,H2O)
BDiff;
%{
DkNe  = 9400*theta^2/tau/S/rhos*(T/M(1))^(1/2);
DkH2  = 9400*theta^2/tau/S/rhos*(T/M(2))^(1/2);
DkCH4 = 9400*theta^2/tau/S/rhos*(T/M(3))^(1/2);
DkCO2 = 9400*theta^2/tau/S/rhos*(T/M(4))^(1/2);
DkCO  = 9400*theta^2/tau/S/rhos*(T/M(5))^(1/2);
DkH2O = 9400*theta^2/tau/S/rhos*(T/M(6))^(1/2);
%}
dpore = 5e-7/2;
DkNe  = 9700*dpore*(T/M(1))^(1/2);
DkH2  = 9700*dpore*(T/M(2))^(1/2);
DkCH4 = 9700*dpore*(T/M(3))^(1/2);
DkCO2 = 9700*dpore*(T/M(4))^(1/2);
DkCO  = 9700*dpore*(T/M(5))^(1/2);
DkH2O = 9700*dpore*(T/M(6))^(1/2);

[DkNe; DkH2; DkCH4; DkCO2; DkCO; DkH2O]';
 
pNe = P -  pCH4 -  pCO2  -  pCO2 -  pH2 -  pH2O;
yCH4 = pCH4/P; yCO2 = pCO2/P; yCO = pCO/P; yH2 = pH2/P; yH2O = pH2O/P;
yNe = pNe/P;

Ne = 1; H2 = 2; CH4 = 3; CO2 = 4; CO = 5; H2O = 6;
DmCH4 =(1.0-yCH4)/( yNe/BDiff(CH4,Ne) + yH2/BDiff(CH4,H2)   + yCO/BDiff(CH4,CO) ...
                        + yCO2/BDiff(CH4,CO2) + yH2O/BDiff(CH4,H2O));
DmCO2 =(1.0-yCO2)/( yNe/BDiff(CO2,Ne) + yH2/BDiff(CO2,H2)   + yCO/BDiff(CO2,CO) ...
                        + yCH4/BDiff(CO2,CH4) + yH2O/BDiff(CO2,H2O));
DmCO  =(1.0-yCO)/( yNe/BDiff(CO,Ne) + yH2/BDiff(CO,H2)   + yCO2/BDiff(CO,CO2) ...
                        + yCH4/BDiff(CO,CH4) + yH2O/BDiff(CO,H2O)); 
DmH2O =(1.0-yH2O)/( yNe/BDiff(H2O,Ne) + yH2/BDiff(H2O,H2)   + yCO2/BDiff(H2O,CH4) ...
                        + yCH4/BDiff(H2O,CO2) + yH2/BDiff(H2O,CO));     
DmH2 =(1.0-yH2)/( yNe/BDiff(H2,Ne) + yCH4/BDiff(H2,CH4)   + yCO2/BDiff(H2,CO2) ...
                        + yCO/BDiff(H2,CO) + yH2O/BDiff(H2,H2O));  
                    
    DeffCH4 = (tau/theta)/(1/DmCH4+1/DkCH4);
    DeffCO2 = (tau/theta)/(1/DmCO2+1/DkCO2);
    DeffCO  = (tau/theta)/(1/DmCO+1/DkCO);
    DeffH2O = (tau/theta)/(1/DmH2O+1/DkH2O);
    DeffH2  = (tau/theta)/(1/DmH2+1/DkH2);                    
   [DeffCH4; DeffCO2; DeffCO; DeffH2O; DeffH2]';
   D1 = DeffCH4;
   D2 = DeffCO2;
   D3 = DeffCO;
   D4 = DeffH2O;
   D5 = DeffH2;
   
   
end
