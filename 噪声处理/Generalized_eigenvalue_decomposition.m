function [x] = Generalized_eigenvalue_decomposition(y,d)
%yΪ���������������Ƶ���ٶ�y=x+d,d�Ǻ�y�ȳ�����������Ƶ��һ��Ҫ�ȳ�������
%���㷨�����ɫ����
%
%
%
Ry = cov(y,y);
Rd = cov(d,d);
la0 = 4.2;
deta = 6.25;                              %la0��deta��Ϊ�����и�����ֵ
[U,Eigen_general] = eig((Ry-Rd),Rd);      %��������ֵ�ֽ�
%%%%���ź��ӿռ���������ֽ⣬�Ա����ά��%%%%
Ka = Rd\Ry - eye(size(Ry));               %����Ka����ϵͳ��ʾ���������ʽ����inv��Rd��*Ry
[Ux,Eigen_signalsubspace] = eig(Ka);
%%%%������ֵ�Խ���������%%%%
M = 0;
tmp = zeros(1,size(Eigen_signalsubspace));
for i=1:size(Eigen_signalsubspace)
   tmp(i)=Eigen_signalsubspace(i,i);
   if Eigen_signalsubspace(i,i) > 0
      M = M + 1;                          %�õ������������ֵ�ĸ���   
   end
end
tmp = sort(tmp,'descend');                %��������
%%%%�����������ճ����Լ�Ԫ��q%%%%
SNRdb = 0;
for i=1:M
   SNRdb = SNRdb + tmp(i);
end
SNRdb = 10*log10(SNRdb/(size(Eigen_signalsubspace)));
la = zeros(1,M);
for i=1:M
   if (SNRdb<=(-5))
      la(i) = 5;
   elseif (SNRdb>=20)
      la(i) = 1;
   else
      la(i) = la0 - tmp(i)/deta;
   end
end
%%%%ȷ���������Թ�����%%%%
g = zeros(1,size(Eigen_signalsubspace));
for i=1:size(Eigen_signalsubspace)
   if (i>=1 && i<=M)
      g(i) = tmp(i)/(tmp(i)+la(i));
   elseif (i>M && i<=size(Eigen_signalsubspace))
      g(i) = 0;
   end
end
G = diag(g);
Htdc = U'\G*U';                           %U����ת�þ������G�ٳ���U��ת��

x = Htdc*y;
      

   
   
   




