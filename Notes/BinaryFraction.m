function BinaryFraction()
clear all 
clc

xs = input('Enter the decimal number:   ');

q = 11;
i = 0;
x = xs;
while x>0 & i < 11
    q = floor(x*2);
    x = 2*x - q;
    i = i + 1;
    R(u) = q;
end
i = i + 1;
R(i) = q;
N = length(R)+1;

for k = 1:length(R)
    Dig(k) = R(N-k);
end
u = 0;
for j = 1:length(R)
    u = u + R(j)*10^(j-1);
end

fprintf('%16s %i \n %2s %10d \n', 'Decimal = ', xs,'Binary = ', u');
end