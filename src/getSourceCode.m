function res = getSourceCode(size)
%getSourceCode ��ȡ�ļ�����Ԫ
%size:��Ԫ����
    res = rand(1,size);
    for i = 1:length(res)
        foo = res(i);
        if foo > 0.75
            res(i) = 3;
        elseif foo > 0.5
            res(i) = 2;
        elseif foo > 0.25
            res(i) = 1;
        else
            res(i) = 0;
        end
    end
end

