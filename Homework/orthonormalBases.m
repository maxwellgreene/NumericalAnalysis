function orthonormalBases
clear all
clc

A = [1,0,-1,1
     0,2,1,0
     0,0,1,1];

B = A;

for j = 1:3
    A(j,:) = A(j,:)/A(j,j);
    for i = 1:3
        if i ~= j
            A(i,:) = -A(j,:)*A(i,j)+A(i,:);
        end 
    end 
end

A


fprintf('Orthogonal Basis for Column Space\n');
A(:,1), A(:,2), A(:,3)


for i = 1:3
    for j = 1:4
        AT(j,i) = B(i,j);
    end
end

AT

for j = 1:3
    AT(j,:) = AT(j,:)/AT(j,j);
    for i = 1:4
        if i ~= j
            AT(i,:) = -AT(j,:)*AT(i,j)+AT(i,:);
        end 
    end 
end


fprintf('Orthogonal Basis for Row Space\n');
AT(1,:), AT(2,:), AT(3,:)
