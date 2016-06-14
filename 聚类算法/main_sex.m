clc;clear all;close all;
[x,fs] = wavread('quzaoshengjieguo.wav');
%result=Sex_distinction(x);
TP_max = 0.02; %�����������趨Ϊ40ms
TP_min = 0.0025; %��С���������趨Ϊ2.5ms
[col1,row] = size(x);
xx = zeros(col1,1);
if row == 2
   xx = (x(:,1)+x(:,2))./2;%���˫�������ϲ��ɵ�����
else
   xx = x;
end
%%%%����������֮ǰ��Ҫ���϶˵���%%%%

%%%%��������%%%%
a = max(xx);
coefficient = 0.7;%�����ԵĲ���
threshold = a*coefficient;
for i=1:col1
   if xx(i,1)>=threshold
      xx(i,1) = xx(i,1) - threshold;
   elseif xx(i,1)<threshold
      xx(i,1) = xx(i,1) + threshold;   
   end
end
%%%%��֡��Ӵ���֡���趨Ϊ40ms��֡��Ϊ10ms%%%%
n = 6400;      %����һ֡�ĳ��ȣ�����ֵ��û�л��㣬�����40ms����Ϊ�����������趨Ϊ40ms
n_shift = 1600;  %����֡�Ƶĳ��ȣ�����ֵ��û�л��㣬�����10ms
flame = ceil(col1/n_shift)-3;
surPlus = rem(col1,n_shift);
S = zeros(flame,n);
for i=1:flame
   if surPlus>0&&i==flame
      S(i,:) = xx((i-2)*n_shift+1+surPlus:(i+3)*n_shift+surPlus,1).*hamming(n);
      break
   end
   S(i,:) = xx((i-1)*n_shift+1:(i+3)*n_shift,1).*hamming(n);
end
%%%%��ϵ��D(k)%%%%
D=zeros(flame,n);
for i=1:flame
   for j=1:n
      for p=1:n
      D(i,j) = D(i,j)+abs(S(i,mod((p+j),n-2)+1)-S(i,p));
      end
   end
end
%%%%����D(i,j)�ľֲ���С��,ͳ��ΪΪM�����������˵�%%%%
TP = zeros(flame,1);
for i=1:flame
   Min_location = find(diff(sign(diff(D(i,:))))>0)+1;
   Min_value = D(i,Min_location);
   M = length(Min_location);
   if M<=1     %���С�ڵ���1��Ϊ����֡
      TP(i) = 0;
      break
   elseif M==2
      P1 = min(Min_value);
      P2 = max(Min_value);
      if P2<TP_min
         TP(i) = 0;
         break
      elseif P1>=TP_min
         TP(i) = P1;
         break
      else
         TP(i) = P2;
         break
      end
%    elseif M>=3
%       %tmp = find(min(Min_value)>=TP_min&min(Min_value)<=TP_max);
%       TP(i) = min(D(i,tmp));
   end
end
%%%%������֡�Ļ�������ȡƽ��%%%%
TP_mean = mean(TP);
Frequency = 1/TP_mean
if Frequency<=200
   sex = '��';
elseif Frequency>200
   sex = 'Ů';
end