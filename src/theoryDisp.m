%{
    �������û�ԭ��չʾ����������������Ĵ���
    �������ŵ���main.m
%}
close all;
%������Ԫ����
codeSize = 5;
%�ز�Ƶ��
carrier_freq = 1e3;
%�ز�������
SampleRate = 25*1e3;
%�ز���������
SamplePoint = 25;

%����������λ���ز�
carrier = [carrierGen(carrier_freq,SampleRate,SamplePoint,0);
    carrierGen(carrier_freq,SampleRate,SamplePoint,pi/2);
    carrierGen(carrier_freq,SampleRate,SamplePoint,pi);
    carrierGen(carrier_freq,SampleRate,SamplePoint,3*pi/2)];

figure;
plot(carrier(1,:));
hold on;
plot(carrier(2,:));
hold on;
plot(carrier(3,:));
hold on;
plot(carrier(4,:));
hold on;
title('�ز�');
legend('����λ0','����λpi/2','����λpi','����λ3*pi/2');

%�����û���Ԫ
sourceCode = [1 2 3 0 3 1 0 2];

%���ɲ����
diffCode = myDiff(sourceCode);
figure;
subplot(2,1,1);
stairs(sourceCode);
title('���ǰ');
set(gca,'XLim',[0 11]); %X���������ʾ��Χ
set(gca,'YLim',[-1 4]); %Y���������ʾ��Χ
subplot(2,1,2);
stairs(diffCode);
title('��ֺ�');
set(gca,'XLim',[0 11]); %X���������ʾ��Χ
set(gca,'YLim',[-1 4]); %Y���������ʾ��Χ

%����
modu = modulate(diffCode,carrier,SamplePoint);
figure;
plot(modu);
title('���ƽ��');

%��ʾ��������
receive = modu;

%���
%�ӳ�һ����Ԫ����
delay = receive(SamplePoint+1:end);
%�Ƴ����һ����Ԫ����
modu2 = receive(1:(length(diffCode)-1)*SamplePoint);
%���
phase = delay.*modu2;
figure;
subplot(3,1,1);
plot(modu2);
title('�����ź�')
subplot(3,1,2);
plot(delay);
title('�ӳٽ��');
subplot(3,1,3);
plot(phase);
title('��˽��');
figure;
fft_point = 512;
plot(linspace(0,1,fft_point),abs(fft(modu,fft_point)));
hold on;
plot(linspace(0,1,fft_point),abs(fft(phase,fft_point)));
title('Ƶ��ͼ');
xlabel('����Ƶ��(��/rad)')
legend('���ǰ','�����');

%�о�
res = judge(phase,SamplePoint);
figure
plot(phase);
figure;
subplot(2,1,1);
stairs(sourceCode);
title('�û���Ԫ');
set(gca,'XLim',[0 9]); %X���������ʾ��Χ
set(gca,'YLim',[-1 4]); %Y���������ʾ��Χ
subplot(2,1,2);
stairs(res);
title('�о����');
set(gca,'XLim',[0 9]); %X���������ʾ��Χ
set(gca,'YLim',[-1 4]); %Y���������ʾ��Χ
