function res = deModulate(input,SamplePoint)
%deModulate ���ģ��
%input�����յ����ź�
%��������ӳ���˵ķ���ɽ��
    %�ӳ٣����ƣ�һ��
    delay = input(SamplePoint+1:end);
    %�Ƴ����һ����Ԫ����
    input = input(1:length(input)-SamplePoint);
    %��Ե����
    res = delay.*input;
end

