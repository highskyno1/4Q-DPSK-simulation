%{
    本代码用户原理展示，不含加入白噪声的代码
    仿真代码放到了main.m
%}
close all;
%仿真码元数量
codeSize = 5;
%载波频率
carrier_freq = 1e3;
%载波采样率
SampleRate = 25*1e3;
%载波采样点数
SamplePoint = 25;

%生成四种相位的载波
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
title('载波');
legend('初相位0','初相位pi/2','初相位pi','初相位3*pi/2');

%生成用户码元
sourceCode = [1 2 3 0 3 1 0 2];

%生成差分码
diffCode = myDiff(sourceCode);
figure;
subplot(2,1,1);
stairs(sourceCode);
title('差分前');
set(gca,'XLim',[0 11]); %X轴的数据显示范围
set(gca,'YLim',[-1 4]); %Y轴的数据显示范围
subplot(2,1,2);
stairs(diffCode);
title('差分后');
set(gca,'XLim',[0 11]); %X轴的数据显示范围
set(gca,'YLim',[-1 4]); %Y轴的数据显示范围

%调制
modu = modulate(diffCode,carrier,SamplePoint);
figure;
plot(modu);
title('调制结果');

%演示不加噪声
receive = modu;

%解调
%延迟一个码元周期
delay = receive(SamplePoint+1:end);
%移除最后一个码元周期
modu2 = receive(1:(length(diffCode)-1)*SamplePoint);
%相乘
phase = delay.*modu2;
figure;
subplot(3,1,1);
plot(modu2);
title('接收信号')
subplot(3,1,2);
plot(delay);
title('延迟结果');
subplot(3,1,3);
plot(phase);
title('相乘结果');
figure;
fft_point = 512;
plot(linspace(0,1,fft_point),abs(fft(modu,fft_point)));
hold on;
plot(linspace(0,1,fft_point),abs(fft(phase,fft_point)));
title('频谱图');
xlabel('数字频率(π/rad)')
legend('解调前','解调后');

%判决
res = judge(phase,SamplePoint);
figure
plot(phase);
figure;
subplot(2,1,1);
stairs(sourceCode);
title('用户码元');
set(gca,'XLim',[0 9]); %X轴的数据显示范围
set(gca,'YLim',[-1 4]); %Y轴的数据显示范围
subplot(2,1,2);
stairs(res);
title('判决结果');
set(gca,'XLim',[0 9]); %X轴的数据显示范围
set(gca,'YLim',[-1 4]); %Y轴的数据显示范围
