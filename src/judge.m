function res = judge(input,SamplePoint)
%judge ��Ԫ�о�
%input��������ź�
%SamplePoint��ÿһ���Ľ�����Ԫ��Ӧ�Ĳ�������

%��¼��һ�γ���ƫ��Ϊ0����Ԫ���ڲ���
start_odd = input(1:SamplePoint);
%�Ƴ���֪���Ϊ1�ĵ�һ����Ԫ����
input = input(SamplePoint+1:end);
%��ʼ��res����������ٶ�
res = zeros(1,length(input)/SamplePoint);
for i = 1:length(input)/SamplePoint
    %��ȡ��Ӧ����Ԫ����
    foo = input((i-1)*SamplePoint+1:i*SamplePoint);
    %���������Ԫ���ڵ�ƽ��ֵ
    bar = mean(foo);
    if bar > 0.25
        %ƽ��ֵ������ֵ��˵��ƫ�õ���0�Ϸ�
        res(i) = 0;
    elseif bar < -0.25
        %ƽ��ֵС����ֵ��˵��ƫ�õ���0�·�
        res(i) = 2;
    else
        %û��ƫ�ã�˵����������Ԫ1��3
        %���ϴε�ƫ��Ϊ0����Ԫ���ڲ������Ƚ�
        bar = foo.*start_odd;
        if sum(bar) > 0
            %ͬ��Ϊ3
            res(i) = 3;
        else
            %����Ϊ1
            res(i) = 1;
        end
        %��¼��һ��ƫ��Ϊ0����Ԫ���ڲ���
        start_odd = foo;
    end
end
end

