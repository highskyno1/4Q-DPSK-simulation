%{
    ���������ڶ��Ľ��Ʋ���������ϵͳ��4Q-DPSK�����з��棬
    ������������������ʵĹ�ϵ����
%}
close all;
%������Ԫ����
codeSize = 1e5;
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

%�����û���Ԫ
%sourceCode = [2 3 3 2 2];
sourceCode = getSourceCode(codeSize);
%���ɲ����
diffCode = myDiff(sourceCode);
%����
modu = modulate(diffCode,carrier,SamplePoint);
send = modu;

snr_start = -30;
snr_end = 10;
snr_div = 0.1;
snr_size = floor((snr_end - snr_start)/snr_div);
errorRate = zeros(1,snr_size);
parfor snr_index = 1:snr_size
    snr = snr_start + snr_div * snr_index;
    %����
    receive = awgn(send,snr,powerCnt(send));
    %���
    phase = deModulate(receive,SamplePoint);
    %�о�
    res = judge(phase,SamplePoint);
    %��¼������
    errorRate(snr_index) = 1 - rightRateCnt(res,sourceCode);
end
plot(linspace(snr_start,snr_end,snr_size),errorRate);
title('�����&�����ʹ�ϵ����');
xlabel('�����(dB)');
ylabel('������');