function [weights,dataSet,labelMat]=logisticRegression(filename)
    format long
    [dataSet,labelMat]=loadDataSet(filename);
    [m,n]=size(dataSet);
    %alpha = 0.001;  %��Ŀ���ƶ��Ĳ���
    maxCycles = 500;    %��������
    weights = ones(1,n);
    for j=1:maxCycles
        dataIndex=1:1:m;
        for i=1:m
            if(isempty(dataIndex))
                break;
            end
            alpha = 4/(1.0+j+i)+0.0001;
            randIndex=ceil(rand(1,1)*length(dataIndex));
            h=sigmoid(weights*dataSet(randIndex,:).');
            error=(labelMat(randIndex,:)-h);
            weights = weights + alpha * error * dataSet(randIndex,:);
            dataIndex(:,randIndex)=[];
        end
    end

end

%��ȡ�ı����ݣ��Ծ�����ʽ����
function [dataSet,labelMat]=loadDataSet(filename)
    format long
    dataMatTemp=importdata(filename,'\t');  %���ļ����ݶ�ȡ��һ������
    [m,n]=size(dataMatTemp);
    dataSet=zeros(m,n);
    dataSet(:,1)=1;
    dataSet(:,2:n)=dataMatTemp(:,1:n-1);
    labelMat=dataMatTemp(:,n);
end

%Sigmoid����
function sigmoidre=sigmoid(x)
    format long
    sigmoidre=1.0./(1+exp(-x));
end



