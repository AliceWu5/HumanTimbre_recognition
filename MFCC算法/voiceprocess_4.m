 clc;clear all;close all;
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %MFCC������ȡ����-��֡����
 %���룺wav�ļ�
 %�����MFCC����
 %�����ˣ��ų���
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 [signalspeech,fs,bit]=wavread('sa1.wav');              %�ļ���ȡ
 %[StartPoint,EndPoint]=vad(signalspeech); %%��ʼ�㣬��ֹ��---��Ϊ�����ٶ�����û�е���
 %MfccCoefficient=mfcc(signalspeech(StartPoint:EndPoint));  %�Զϵ㹤��
 
 framelength=44100;                                                 %֡����
 framenumber=fix(length(signalspeech)/framelength);                    %����֡��

    i=1;
    framesignal = signalspeech((i-1)*framelength+framelength/2:i*framelength);    %��ȡ��֡���֡����
    MfccCoefficient=mfcc(framesignal);                                      %������MFCC������������mfcc.m
    Mave(:,:,1)=mean(MfccCoefficient);                                     %��һ��             
    %plot(MfccCoefficient);
    for i=2;framenumber;
         framesignal = signalspeech((i-1)*framelength+22050:i*framelength);    %��ȡÿ֡����
        MfccCoefficient=mfcc(framesignal);
        Mave(:,:,i)=mean(MfccCoefficient);                                  %ÿһ��
    end
    
    for j=1:framenumber;                                                %��ȡ����ά�����еĸ���ȤԪ��
        for k=1:12;
            M(k,j)=Mave(1,k,j);
        end
    end
    L=0;
    
     for l=1:12;                                                         %�Զ�ά�����12��������ƽ��ֵ
       Me(l)=mean(M(l,:));
    end