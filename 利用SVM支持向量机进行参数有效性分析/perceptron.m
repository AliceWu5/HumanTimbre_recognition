function [w] = perceptron(x,flag) 
%Ҫ��xΪm*nά����mΪѵ������������nΪ����������ά��
%flagΪmά����������־λ
[m,n] = size(x);
new_x = zeros(m,n+1);
for i=1:m            %��ѵ��������չ�����ϱ�־λ
   if flag(i)==1
      new_x(i,:) = [x(i,:) 1];
   elseif flag(i)==-1
      new_x(i,:) = [x(i,:) 1]*(-1);
   end
end
new_x = new_x'; 
W = zeros(1,n+1);
for i=1:m
   wrong_number = 0;
   if W*new_x(:,i)<=0
      W = W+new_x(:,i)';
      wrong_number = wrong_number + 1;
   end
   if wrong_number == 0
      break
   end
end
w = W;