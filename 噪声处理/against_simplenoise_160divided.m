function [pure_sound] = against_simplenoise(x,y)
%����(����)�׼����Կ�������
%[x fs] = wavread('filename1.wav')����������Ԥ��ȡ��Ƶ�ļ�
%[y fs] = wavread('filename2.wav')����������Ԥ��ȡ��������Ƶ�ļ�
%x��yΪʱ��㣻fsΪ����Ƶ��
%�÷�����������������Ҫ��Ҫ����������Ƶ����
%
%
[col1,row] = size(x);
[col2,row] = size(y);
n_1 = col1;
n_2 = col2;
xx = zeros(col1,1);
yy = zeros(col2,1);
if row == 2
   xx = (x(:,1)+x(:,2))./2;
   yy = (y(:,1)+y(:,2))./2;%���˫�������ϲ��ɵ�����
else
   xx = x;
   yy = y;
end
% subplot(212);
% plot(xx);
% title('ȥ����');
%%%%��֡%%%%  
n = 16000;
frame_1 = (n_1 - rem(n_1,n))/n + 1;
frame_2 = (n_2 - rem(n_2,n))/n ; %���������뾡��ȡ��֡(������)��ֻ���Զ࣬��Ҫ��ȡ�����
xx_split = zeros(frame_1,n);
yy_split = zeros(frame_2,n);
Fxx = zeros(frame_1,n);
Fyy = zeros(frame_2,n);
for i = 1:frame_1
    if i == frame_1
      xx_split(i,1:rem(n_1,n)) = xx(((frame_1-1)*n+1):n_1,1);
      xx_split(i,(rem(n_1,n)+1):n) = 0;
      xx_split(i,:) = xx_split(i,:)'.*hamming(n);
      Fxx(i,:) = abs(fft(xx_split(i,:),n)); %��֡�����и���Ҷ�任
      break
   end
   xx_split(i,:) = xx(((i-1)*n+1):(i*n),1).*hamming(n);%�Ӵ���
   Fxx(i,:) = abs(fft(xx_split(i,:),n));
end
ang = zeros(frame_1,n);
for i = 1:frame_1
   ang(i,:) = angle(fft(xx_split(i,:),n)); %%%�������Ϣ�Լ�������
   Fxx(i,:) = Fxx(i,:).^2;
end
for i = 1:frame_2
   yy_split(i,:) = yy(((i-1)*n+1):(i*n),1).*hamming(n);
   Fyy(i,:) = abs(fft(yy_split(i,:),n));
end
%%%�����������׵�����%%%
E_noise = zeros(1,n);
for i = 1:frame_2
   E_noise(1,:) = E_noise(1,:) + Fyy(i,:).^2; 
end
E_noise(1,:) = E_noise(1,:)./frame_2;
%%%�׼���%%%
beta = 1;%%%����ϵ������1ʱΪ������
S = zeros(frame_1,n);
for i = 1:frame_1
   if i == frame_1
      S(i,:) = sqrt(Fxx(i,:) - beta*E_noise(1,:));
      S(i,:) = S(i,:).*exp(1j*ang(i,:));
      S(i,:) = real(ifft(S(i,:),n))'./hamming(n); 
      for p = (rem(n_1,n)+1):n
         S(i,p) = 0;
      end
      break
   end
   S(i,:) = sqrt(Fxx(i,:) - beta*E_noise(1,:));
   S(i,:) = S(i,:).*exp(1j*ang(i,:));
   S(i,:) = real(ifft(S(i,:),n))'./hamming(n); %%%������λ���ٽ���ȥ������
   
end

result=[];
for count=1:7;
    result=[result S(i,:)];
end
result1 = [S(1,:) S(2,:) S(3,:) S(4,:) S(5,:) S(6,:) S(7,:)];
% result=int(result);
 subplot(211);

plot(result);
subplot(212);
plot(result1);
% title('ԭʼ');

audiowrite('quzaoshengjieguo1.wav',result,16000)