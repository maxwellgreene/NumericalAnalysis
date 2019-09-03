function BinaryWhole()
clear all6
clc
xs = input('Enter the decimal number? y/n \n');
xs
q = 11;
i = 0;
x = xs;

while x > 0
    q = floor(x/2);
    r = x - 2*q;
    [x,q,r];
    i = i + 1;
    R(i) = r;
    x = q;
end
i = i + 1;
R(i)=q;
N = length(R)+1;

for k = 1:length(R)
    Dig(k) = R(N-k);
end
u=0;
for j = 1:length(R)
    u = u + Dig(j)*10^(j-1);
end

fprintf('%16s %i \n %2s %d \n', 'Decimal = ', xs, 'Binary  = ', u');

end