clc;clear all;close all;
[x,fs] = wavread('noise_test.wav');             %�����ȡ
%%%%%����������against_simplenoise��������һ������
y(:,1)=x(8192:24575,1);                       %����ȡ��
y(:,2)=x(8192:24575,2);                       %����ȡ��
against_simplenoise(x,y);
%%%%����������Generalized_eigenvalue_decmposition�������ӿռ�ֽ⣬����һ������
% y(:,1)=x(fs/160:(fs/80-1),1);                       %0.5�뵽1.5����Ϊ����ȡ��
% y(:,2)=x(fs/160:(fs/80-1),2);                       %0.5�뵽1.5����Ϊ����ȡ��
% %�����ϲ�
% [col1,row] = size(x);
% [col2,row] = size(y);
% n_1 = col1;
% n_2 = col2;
% xx = zeros(col1,1);
% yy = zeros(col2,1);
% if row == 2
%    xx = (x(:,1)+x(:,2))./2;
%    yy = (y(:,1)+y(:,2))./2;                     %���˫�������ϲ��ɵ�����
% else
%    xx = x;
%    yy = y;
% end
% xx1=xx(fs/2:n_1);                               %xx1Ϊȥ��ǰ��֡�Ĵ����������ź�
% lengthxx1=length(xx1);                                %xx1����
% % frame_num = round(lengthxx1*2/fs);
% % for i=1:frame_num
% %     x2process=xx1((i-1)*fs/2+1:i*fs/2);
% %     outputmatrix(i,:)=Generalized_eigenvalue_decomposition_enhanced(x2process,yy,i);
% % end
% i=4;
%      x2process=xx1((i-1)*fs/160+1:i*fs/160);
%      outputmatrix(i,:)=Generalized_eigenvalue_decomposition_enhanced(x2process,yy,i);