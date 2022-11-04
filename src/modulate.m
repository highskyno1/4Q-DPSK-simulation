function res = modulate(code,carrier,sampleSize)
%modulate ����
%code���û��Ľ�����Ԫ
%carrier������λ�ز�
%sampleSize��ÿһ��Ԫ��Ӧ��������
    res = zeros(1,length(code)*sampleSize);
    for i = 1:length(code)
        res((i-1)*sampleSize+1:i*sampleSize) = carrier(code(i)+1,:);
    end
end

