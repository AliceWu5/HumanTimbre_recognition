function [x] = Generalized_eigenvalue_decomposition_enhanced(y1,d,flame)

%���㷨���ÿһ֡����
%���㷨�����ɫ����
%yΪ���������������Ƶ֡���ٶ�y=x+d,d�Ǻ�y�ȳ�����������Ƶ֡
%���Ӻ����˲���
%flameΪ��ǰ�����֡������һ֡�ڶ�֡...��

Ry = (y1*y1')./length(y1);
Rd = (d*d')./length(d);

% temp1=[y1';y1'];
% Ry=cov(temp1);
% temp2=[d';d'];
% Rd=cov(temp2);

K = length(y1);
[~,Eigen_x] = eig(Ry-Rd);
[~,Eigen_d] = eig(Rd);
la0 = 4.2;
deta = 6.25;    
afa = 0.98;
%%%%����r%%%%
r = zeros(1,K);
for i=1:K
   r(i) = Eigen_x(i)/Eigen_d(i);
end
rr(flame,:) = r(1,:);
%%%%����ϵ��%%%%
SNRdb = zeros(1,K);
for i=1:K
   SNRdb(i) = 10*log10(r(i));
end
la = zeros(1,K);
for i=1:K
   if (SNRdb<=(-5))
      la(i) = 5;
   elseif (SNRdb>=20)
      la(i) = 1;
   else
      la(i) = la0 - SNRdb(i)/deta;
   end
end
%%%%��ȡG����Խ���Ԫ��%%%%
[V,Eigen_general] = eig((Ry-Rd),Rd);      %�д�֤ʵ
g = zeros(1,K);
for i=1:K
   if Eigen_general(i,i)<0
      Eigen_general(i,i) = 0;
   end
   g(i) = Eigen_general(i,i)/(Eigen_general(i,i)+la(i));
   gg(flame,i) = g(1,i);
end
%%%%������������%%%%
sigma = zeros(1,K);
for i=1:K
   if flame == 1                          %����ǵ�һ֡
      sigma(i) = afa + (1 - afa) * max((r(i) - 1),0);
   else
      sigma(i) = afa * sqrt(gg(flame - 1,i)) * rr(flame-1,i) + (1 - afa) * max((r(i) - 1),0);
   end
end
%%%%���ESI�����%%%%
SNR_ESIdb = zeros(1,K);
for i=1:K
   SNR_ESIdb(i) = sigma(i)/((1-g(i))^2*sigma(i)+(g(i))^2);
   SNR_ESIdb(i) = 10*log10(SNR_ESIdb(i));
end
%%%%��ú����˲����������������Ԫ�ز����ɾ���G%%%%
g_modulate = zeros(1,K);
q = zeros(1,K);
for i=1:K
   if SNR_ESIdb(i)<0
      q(i) = 0.8;
   else
      q(i) = 1;
   end
   g_modulate(i) = q(i)*g(i);
end
G_modulate = diag(g_modulate);
%%%%�����ǿ��������źţ���ǰ֡��%%%%
x = V'.*G_modulate.*V'.*y1;
plot(x);


   

      