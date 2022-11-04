function res = myDiff(input)
%myDiff 我的差分函数
%input：需要差分处理的四进制信号
    input = [1 input];
    %先对1和3做差分
    %记录上一次的奇数状态
    last_odd = 1;
    for i = 2:length(input)
        if mod(input(i),2) == 1
            if input(i) == 1
                input(i) = last_odd;
            else
                input(i) = mod(last_odd + 2,4);
            end
            last_odd = input(i);
        end
    end
    %对全部码元做2次差分
    res = zeros(1,length(input)+1);
    for i = 1:length(input)
        res(i+1) = mod(res(i) + input(i),4);
    end
end

