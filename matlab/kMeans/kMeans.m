function [centroids,clusterAssment]=kMeans(dataSet,k)
    clusterAssment=dataSet;
    centroids=k;
end

%��ȡ�ı����ݣ��Ծ�����ʽ����
function dataSet=loadDataSet(filename)
    dataSet=importdata(filename,'\t');
end

%��������֮�����
function dist=distEclud(vecA, vecB)
    vecSum=(vecA(1,:)-vecB(1,:)).^2;
    dist=sqrt(vecSum(:,1)+vecSum(:,2));
end

function centroids=randCent(dataSet,k)
    [m,n]=size(dataSet);    % m:���x�ж�����   n:���x�ж�����
    centroids=zeros(k,n);
    for j=1:n
       minJ=min(dataSet(:,j));  %��j�����ֵ
       maxJ=max(dataSet(:,j));  %��j����Сֵ
       rangeJ=maxJ-minJ;
       centroids(:,j)=minJ+rangeJ*rand(k,1);    %�������������Ϊ�ص�����
    end
end
