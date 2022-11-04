function res = modulate(code,carrier,sampleSize)
%modulate 调制
%code：用户四进制码元
%carrier：四相位载波
%sampleSize：每一码元对应采样点数
    res = zeros(1,length(code)*sampleSize);
    for i = 1:length(code)
        res((i-1)*sampleSize+1:i*sampleSize) = carrier(code(i)+1,:);
    end
end

