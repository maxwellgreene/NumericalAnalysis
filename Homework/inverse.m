function I = inverse
   A = [1,0,3,2;-1,1,2,6;0,3,-1,7;1,2,3,4]
   invA = inv(A)
   I = eye(length(A),length(A));
   
   for i = 1:length(A)
       for j = 1:i
           if i ~= j
              I(i,:) = I(i,:)-A(i,j)*I(j,:)
              A(i,:) = A(i,:)-A(i,j)*A(j,:)
           else
              I(i,:) = I(j,:)/A(i,j)
              A(i,:) = A(j,:)/A(i,j)
           end
       end
   end
   
   for j = 1:length(A)
       for i = 1:j
           if i ~= j
              I(i,:) = I(i,:)-A(i,j)*I(j,:)
              A(i,:) = A(i,:)-A(i,j)*A(j,:)
           else
              I(i,:) = I(j,:)/A(i,j)
              A(i,:) = A(j,:)/A(i,j)
           end
       end
   end
   disp("The matrix has been reduced to...")
   A
   disp("checking...")
   invA
   disp("should be equal to the answer...")
end