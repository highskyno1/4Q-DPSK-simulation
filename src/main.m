%{
    本代码用于对四进制差分移相键控系统（4Q-DPSK）进行仿真，
    绘制其信噪比与误码率的关系曲线
%}
close all;
%仿真码元数量
codeSize = 1e5;
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

%生成用户码元
%sourceCode = [2 3 3 2 2];
sourceCode = getSourceCode(codeSize);
%生成差分码
diffCode = myDiff(sourceCode);
%调制
modu = modulate(diffCode,carrier,SamplePoint);
send = modu;

snr_start = -30;
snr_end = 10;
snr_div = 0.1;
snr_size = floor((snr_end - snr_start)/snr_div);
errorRate = zeros(1,snr_size);
parfor snr_index = 1:snr_size
    snr = snr_start + snr_div * snr_index;
    %加噪
    receive = awgn(send,snr,powerCnt(send));
    %解调
    phase = deModulate(receive,SamplePoint);
    %判决
    res = judge(phase,SamplePoint);
    %记录误码率
    errorRate(snr_index) = 1 - rightRateCnt(res,sourceCode);
end
plot(linspace(snr_start,snr_end,snr_size),errorRate);
title('信噪比&误码率关系曲线');
xlabel('信噪比(dB)');
ylabel('误码率');