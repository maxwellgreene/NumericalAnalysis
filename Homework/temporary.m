%% Homework #3
%% Problem #1



function A = inverse(A)
   I = eye(3,3)
   for j = 1:3
      A(j,:)=A(j,:)/A(j,j)
      I(j,:)=I(j,:)/A(j,j)
      for i = 1:3 
         if i ~= j
            A(i,:) = -A(i,j)*A(j,:)+A(i,:) 
            y(i,:) = -y(i,j)*A(j,:)+A(i,:) 
         end
      end
   end
end
A