function res = myDiff(input)
%myDiff �ҵĲ�ֺ���
%input����Ҫ��ִ�����Ľ����ź�
    input = [1 input];
    %�ȶ�1��3�����
    %��¼��һ�ε�����״̬
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
    %��ȫ����Ԫ��2�β��
    res = zeros(1,length(input)+1);
    for i = 1:length(input)
        res(i+1) = mod(res(i) + input(i),4);
    end
end

