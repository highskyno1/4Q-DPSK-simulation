function res = deModulate(input,SamplePoint)
%deModulate 解调模块
%input：接收到的信号
%解调基于延迟相乘的非相干解调
    %延迟（左移）一拍
    delay = input(SamplePoint+1:end);
    %移除最后一个码元周期
    input = input(1:length(input)-SamplePoint);
    %点对点相乘
    res = delay.*input;
end

