function res = judge(input,SamplePoint)
%judge 码元判决
%input：解调后信号
%SamplePoint：每一个四进制码元对应的采样点数

%记录上一次出现偏置为0的码元周期波形
start_odd = input(1:SamplePoint);
%移除已知结果为1的第一个码元周期
input = input(SamplePoint+1:end);
%初始化res，提高运行速度
res = zeros(1,length(input)/SamplePoint);
for i = 1:length(input)/SamplePoint
    %截取对应的码元周期
    foo = input((i-1)*SamplePoint+1:i*SamplePoint);
    %计算该组码元周期的平均值
    bar = mean(foo);
    if bar > 0.25
        %平均值大于阈值，说明偏置到了0上方
        res(i) = 0;
    elseif bar < -0.25
        %平均值小于阈值，说明偏置到了0下方
        res(i) = 2;
    else
        %没有偏置，说明是奇数码元1或3
        %与上次的偏置为0的码元周期波形做比较
        bar = foo.*start_odd;
        if sum(bar) > 0
            %同相为3
            res(i) = 3;
        else
            %反相为1
            res(i) = 1;
        end
        %记录这一次偏置为0的码元周期波形
        start_odd = foo;
    end
end
end

