function [res] = carrierGen(freq,sampleRate,size,phase)
%carrierGen �����ز�
%   ������freq:Ƶ�� sampleRate:������ size:�ز����� phase:����λ
    n=0:size-1;
    t=n/sampleRate;%ʱ������
    res=sin(2*pi*freq*t+phase);
end

