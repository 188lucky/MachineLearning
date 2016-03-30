function [weights]=logisticFlame(dataSet,labelMat)
% �߼��ع飬����Flame���ݼ�
%
%
%

    format long
    n=size(dataSet,2);
    alpha = 0.001;  %��Ŀ���ƶ��Ĳ���
    maxCycles = 500;    %��������
    weights = ones(n,1);
    %dataSet*weights
    sigmoid(dataSet*weights)
    for k=1:maxCycles
        h=sigmoid(dataSet*weights);
        error=(labelMat-h);
        weights = weights + alpha *dataSet.'* error;
    end

end

%Sigmoid����
function sigmoidre=sigmoid(x)
    format long
    sigmoidre=1.0./(1+exp(-x));
end



