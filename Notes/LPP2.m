

A1 = [2,    1, 1, 0, 0, 0, 75
     1,    1, 0, 1, 0, 0, 60
     1,    0, 0, 0, 1, 0, 25
  -150, -100, 0, 0, 0, 1,  0];

A2 = [1,  2, 1, 0, 0, 0, 16;
     1,  1, 0, 1, 0, 0,  9;
     3,  2, 0, 0, 1, 0, 24;
   -40,-30, 0, 0, 0, 1,  0];


A3 = [2, 4, 1, 0, 0, 220;
     3, 2, 0, 1, 0, 150;
    -4,-3, 0, 0, 1,   0];


A4 = [2, 3, 1, 0, 0,  90;
     3, 2, 0, 1, 0, 120;
    -7,-5, 0, 0, 1,   0];


A5 = [3, 0, 0, 1, 0, 0, 0, 25;
     1, 1, 1, 1, 0, 0, 0, 20;
     4, 0, 6, 0,-1, 0, 0,  5;
     2, 3, 0, 2, 0,-1, 0,  0;
     2, 2,-6,-1, 0, 0, 1,  0];

A = A1

nr = size(A, 1);
nc = size(A, 2);

for j = 1:nc-1
    
[M, I] = min(A(nr,:)); %%Find the location of the minimum in the last row
for i = 1:nr-1
    PC(i) = A(i,I);    %%This is the pivot volumn
end
PC';

for i = 1:nr-1
LC(i) = A(i,nc);       %%Last column 

end
LC';
Ratio = LC'./PC';      %%The ratio of the last to pivot column

for k = 1:nr-1
    if Ratio(k) < 0 
        Ratio(k) = 1e99;  %%eliminate the negative
    end
end 
[PivPoint, IP]  = min(Ratio)  %%Nonnegtive ratio only
  

A(IP,:) = A(IP,:)/A(IP, I);

for i = 1:nr
    if i ~= IP
    A(i,:)  =-A(i,I)*A(IP, :) + A(i,:);  %%Reduction of the pivot column until only positive
    end                                %%elements in the last row.
end
end
A
max(A(:,length(A)))


