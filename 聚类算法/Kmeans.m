
function [Centre,Result] = Kmeans(data)
%data: ������ϵ��������������
%singer: �������������coefficient: ����ֵ����
%flag: ����Ľ��
[singer,coefficient] = size(data);
K = 4;
centre = zeros(K,coefficient);
for i=1:K                   %��ΪK�࣬��������Լ����ĵ��ѡȡ�д��о�������˳��ѡȡK��
   centre(i,:)=data(i,:);
end                   %centre�����ĵ㣩������

[centre_new,flag,change]=Classify(data,centre);      
while(change==1)
   [centre_new,flag,change]=Classify(data,centre_new); %�������ֱ࣬�����ĵ㲻�ٱ仯
end
Centre = centre_new;
Result = flag;


