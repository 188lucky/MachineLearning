function [weights,dataSet,labelMat]=logisticRegression(filename)
    format long
    [dataSet,labelMat]=loadDataSet(filename);
    n=size(dataSet,2);
    alpha = 0.001;  %��Ŀ���ƶ��Ĳ���
    maxCycles = 500;    %��������
    weights = ones(n,1);
    for k=1:maxCycles
        h=sigmoid(dataSet*weights);
        error=(labelMat-h);
        weights = weights + alpha *dataSet.'* error;
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



