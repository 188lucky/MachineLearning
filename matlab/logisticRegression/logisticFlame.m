function [weights]=logisticFlame(dataSet,labelMat)
% �߼��ع飬����Flame���ݼ�
% dataSet  ���ݼ�
% labelMat ��ǩֵ
%

    %Ĭ���ݶ�������
     format long
     n=size(dataSet,2);
     alpha = 0.02;  %��Ŀ���ƶ��Ĳ���
     maxCycles = 500;    %��������
     weights = ones(n,1);
     for k=1:maxCycles
         h=sigmoid(dataSet*weights);
         error=(labelMat-h);
         weights = weights + alpha *dataSet.'* error;
     end
     weights=weights.';
%     %�Ľ�����ݶ�������
%     format long
%     [m,n]=size(dataSet);
%     %����������ʹ��Flame���ݲ��ԣ�500�����Ч�������ã�100000�����Ч�������ԣ�
%     %����δ���Ľ����ݶ���������500�����Ч���ȸĽ���100000�����Ч��Ҫ��
%     %���Ͻ����Flame���ݼ����������ݼ����ԣ��Ľ�����㷨Ч������
%     maxCycles = 500;    
%     weights = ones(1,n);
%     for j=1:maxCycles
%         dataIndex=1:1:m;
%         for i=1:m
%             if(isempty(dataIndex))
%                 break;
%             end
%             alpha = 4/(1.0+j+i)+0.001;
%             randIndex=ceil(rand(1,1)*length(dataIndex));
%             h=sigmoid(weights*dataSet(randIndex,:).');
%             error=(labelMat(randIndex,:)-h);
%             weights = weights + alpha * error * dataSet(randIndex,:);
%             dataIndex(:,randIndex)=[];
%         end
%     end
end

%Sigmoid����
function sigmoidre=sigmoid(x)
    format long
    sigmoidre=1.0./(1+exp(-x));
end



