
function GetDiff()
clear all
clc

global Pw Num
global  RDeffCH4 RDeffCO2 RDeffCO  RDeffH2O RDeffH2 XR

Pw = -1; Num = 01;
%%%This program computes effective diffusivities versus temperature and
%%%plot the results

prompt  = 'Enter  the catalyst pore diamter (nm)    \n'; 
dpore = input(prompt)*1e4;
for j =2:6
T1 = j*100; %%input(prompt);
DE = CompMixDiffCoeff (T1, dpore)*1e3; %%De is multiplied by 1000 for plotting purposes
%RDeffCH4
DeffVsTemp36Data(j-1,:) =  [T1; DE']';
save DeffVsTemp36Data.mat DeffVsTemp36Data;
end
Temp  = DeffVsTemp36Data(:,1);
DeCH4 = DeffVsTemp36Data(:,2)
DeCO2 = DeffVsTemp36Data(:,3);
DeCO  = DeffVsTemp36Data(:,4);
DeH2O = DeffVsTemp36Data(:,5);
DeH2  = DeffVsTemp36Data(:,6);
 
figure(1)
plot(Temp, DeCH4, '-+', Temp, DeCO2, '-*', Temp, DeCO, '-o', ...
       Temp, DeH2O, '-x',Temp, DeH2,'-d')
xlabel('Temperature (^\circ C)')
if Pw == 1 
ylabel('Effective diffusivity (10^3 \times  cm^2/sec )')
else
ylabel('Diffusion coefficient in mixture (10^3 \times  cm^2/sec )')
end
legend('CH_4', 'CO_2', 'CO','H_2O', 'H_2')
figure(2)
plot(XR, RDeffCH4(:,1), XR, RDeffCH4(:,2),XR, RDeffCH4(:,3), ...
                   XR, RDeffCH4(:,4),XR, RDeffCH4(:,5))
title('CH_4')
legend('200', '300', '400','500','600')
figure(3)
plot(XR, RDeffCO2(:,1), XR, RDeffCO2(:,2),XR, RDeffCO2(:,3), ...
                   XR, RDeffCO2(:,4),XR, RDeffCO2(:,5))
title('CO_2')
legend('200', '300', '400','500','600')               
figure(4)
plot(XR, RDeffCO(:,1), XR, RDeffCO(:,2),XR, RDeffCO(:,3), ...
                   XR, RDeffCO(:,4),XR, RDeffCO(:,5))  
title('CO')
legend('200', '300', '400','500','600') 
figure(5)
plot(XR, RDeffH2O(:,1), XR, RDeffH2O(:,2),XR, RDeffH2O(:,3), ...
                   XR, RDeffH2O(:,4),XR, RDeffH2O(:,5))  
title('H_2O')
legend('200', '300', '400','500','600')
figure(6)
plot(XR, RDeffH2(:,1), XR, RDeffH2(:,2),XR, RDeffH2(:,3), ...
                   XR, RDeffH2(:,4),XR, RDeffH2(:,5))
title('H_2')
legend('200', '300', '400','500','600')
end


function Diff = CompMixDiffCoeff (T, dpore)
global Pw Num
global  RDeffCH4 RDeffCO2 RDeffCO  RDeffH2O RDeffH2 XR

P = 101325;
MCH4 = 16; MCO2 = 44; MCO = 28; MH2O = 18; MH2 = 2;

theta = 0.416; tau = 4; rho = 2.3552; 

   Indx = T/100;
load('EXP36Temp200.MAT')
load('EXP36Temp300.MAT')
load('EXP36Temp400.MAT')
load('EXP36Temp500.MAT')
load('EXP36Temp600.MAT')


    if T == 200
    EXP = EXP36Temp200;
elseif T == 300
    EXP = EXP36Temp300;
elseif T == 400
    EXP = EXP36Temp400;
elseif T == 500
    EXP = EXP36Temp500;
elseif T == 600
    EXP = EXP36Temp600;
end

  x = EXP(:,1);  pCH4 = EXP(:,2); pCO2 = EXP(:,3);
pCO = EXP(:,4);  pH2 =  EXP(:,5); pH2O = EXP(:,6);
pN2 = P -  pCH4 -  pCO2  -  pCO2 -  pH2 -  pH2O;
yCH4 = pCH4/P; yCO2 = pCO2/P; yCO = pCO/P; yH2 = pH2/P; yH2O = pH2O/P;
yN2 = pN2/P;
%%%%%%%%%%%%%%%%%%%%

XR = x;
%%%%%%%%%%%%%%%%%%%
load('DiffCoefficeintsTemp.MAT')
Temp      = DiffCoefficeintsTemp(:,1);
DN2inH2   = DiffCoefficeintsTemp(:,2);
DN2inCH4  = DiffCoefficeintsTemp(:,3);
DN2inCO2  = DiffCoefficeintsTemp(:,4); 
DN2inCO   = DiffCoefficeintsTemp(:,5);
DN2inH2O  = DiffCoefficeintsTemp(:,6);
DH2inCH4  = DiffCoefficeintsTemp(:,7);
DH2inCO2  = DiffCoefficeintsTemp(:,8);
DH2inCO   = DiffCoefficeintsTemp(:,9);
DH2inH2O  = DiffCoefficeintsTemp(:,10);
DCH4inCO2 = DiffCoefficeintsTemp(:,11);
DCH4inCO  = DiffCoefficeintsTemp(:,12);
DCH4inH2O = DiffCoefficeintsTemp(:,13);
DCO2inCO  = DiffCoefficeintsTemp(:,14);
DCO2inH2O = DiffCoefficeintsTemp(:,15);
DCOinH2O  = DiffCoefficeintsTemp(:,16);



for j = Indx:Indx
DmCH4(:,j) =(1.0-yCH4)./( yN2/DN2inCH4(j) + yH2/DH2inCH4(j)   + yCO/DCH4inCO(j) ...
                        + yCO2/DCH4inCO2(j) + yH2O/DCH4inH2O(j));
DmCO2(:,j) =(1.0-yCO2)./( yN2/DN2inCO2(j) + yH2/DH2inCO2(j)   + yCO/DCO2inCO(j) ...
                        + yCH4/DCH4inCO2(j) + yH2O/DCO2inH2O(j));
DmCO(:,j) =(1.0-yCO)./( yN2/DN2inCO(j) + yH2/DH2inCO(j)   + yCO2/DCO2inCO(j) ...
                        + yCH4/DCH4inCO(j) + yH2O/DCOinH2O(j)); 
DmH2O(:,j) =(1.0-yH2O)./( yN2/DN2inH2O(j) + yH2/DH2inH2O(j)   + yCO2/DCO2inH2O(j) ...
                        + yCH4/DCH4inH2O(j) + yH2/DH2inH2O(j));     
DmH2(:,j) =(1.0-yH2)./( yN2/DN2inH2(j) + yCH4/DH2inCH4(j)   + yCO2/DH2inCO2(j) ...
                        + yCO/DH2inCO(j) + yH2O/DH2inH2O(j));  
  TK = Temp(j) + 273.15;  
  %{
DkCH4(j) = 9400*theta^2/tau/S/rho*(TK/MCH4)^(1/2);
DkCO2(j) = 9400*theta^2/tau/S/rho*(TK/MCO2)^(1/2);
DkCO(j)  = 9400*theta^2/tau/S/rho*(TK/MCO)^(1/2);
DkH2O(j) = 9400*theta^2/tau/S/rho*(TK/MH2O)^(1/2);
DkH2(j)  = 9400*theta^2/tau/S/rho*(TK/MH2)^(1/2);
%}
M(1) = 20; M(2) = 2; M(3) = 16; M(4) = 44; M(5) = 28; M(6) = 18; 
  
rpore = dpore*1e-7/2;
DkCH4(j) = 9700*rpore*(T/M(3))^(1/2);
DkCO2(j) = 9700*rpore*(T/M(4))^(1/2);
DkCO(j)  = 9700*rpore*(T/M(5))^(1/2);
DkH2O(j) = 9700*rpore*(T/M(6))^(1/2);
DkH2(j)  = 9700*rpore*(T/M(2))^(1/2);
DkN2(j)  = 9700*rpore*(T/M(1))^(1/2);

end

for j = 1:length(x)
    for k = Indx:Indx
    DeffCH4(j) = (tau/theta)^Pw/(1/DmCH4(j,k)+Num/DkCH4(k));
    DeffCO2(j) = (tau/theta)^Pw/(1/DmCO2(j,k)+Num/DkCO2(k));
    DeffCO(j)  = (tau/theta)^Pw/(1/DmCO(j,k) +Num/DkCO(k));
    DeffH2O(j) = (tau/theta)^Pw/(1/DmH2O(j,k)+Num/DkH2O(k));
    DeffH2(j)  = (tau/theta)^Pw/(1/DmH2(j,k) +Num/DkH2(k));
    end
end

if abs(DeffH2(1) - DeffH2(end)) > 0.0001e-40
    'Diffusivities vary lengthwise'
 [DeffCH4; DeffCO2; DeffCO;  DeffH2O; DeffH2]';
 Diff(1) =  DeffCH4(end);
 Diff(2) =  DeffCO2(end);
 Diff(3) =  DeffCO(end);
 Diff(4) =  DeffH2O(end);
 Diff(5) =  DeffH2(end);
 Indx
 RDeffCH4(:,Indx-1) = DeffCH4;
 RDeffCO2(:,Indx-1) = DeffCO2;
  RDeffCO(:,Indx-1) = DeffCO;
 RDeffH2O(:,Indx-1) = DeffH2O; 
  RDeffH2(:,Indx-1) = DeffH2;
 return
else

[DeffCH4(end); DeffCO2(end); DeffCO(end); ...
                       DeffH2O(end); DeffH2(end)]';
 Diff(1) =  DeffCH4(end);
 Diff(2) =  DeffCO2(end);
 Diff(3) =  DeffCO(end);
 Diff(4) =  DeffH2O(end);
 Diff(5) =  DeffH2(end);
   
end
Diff;
end


