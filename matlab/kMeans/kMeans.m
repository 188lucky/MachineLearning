function [centroids,clusterAssment]=kMeans(dataSet,k)
    [m,n]=size(dataSet);
    clusterAssment = zeros(m,2);    %m��2��ȫ�����,�����洢�ط����������У�һ�м�¼������ֵ����һ�д洢����ǰ�㵽�����ĵľ��룩
    centroids = randCent(dataSet, k);
    clusterChanged = true;
    while clusterChanged
        clusterChanged = false;
        for i=1:m
            minDist=Inf;
            minIndex=-1;
            for j=1:k
                distJI=distEclud(centroids(j,:),dataSet(i,:))   %�������
                if distJI < minDist
                    minDist = distJI;
                    minIndex = j;
                end
            end
            if clusterAssment(i,0)~=minIndex
                clusterChanged = true;
            end
            clusterAssment(i,1) = minIndex;
            clusterAssment(i,2) = minDist^2;
        end
        for cent=1:k
           
        end
%                 for i in range(m):
%             minDist = inf   #������
%             minIndex = -1
%             for j in range(k):
%                 distJI = distEclud(centroids[j,:],dataSet[i,:])     #�������
%                 if distJI < minDist:
%                     minDist = distJI
%                     minIndex = j
%             if clusterAssment[i,0] != minIndex:     #�ر仯
%                 clusterChanged = True
%             clusterAssment[i,:] = minIndex,minDist**2
%         for cent in range(k):
%             ptsInClust = dataSet[nonzero(clusterAssment[:,0].A==cent)[0]]   #�ҳ�����cent�ص�dataSet����
%             centroids[cent,:] = mean(ptsInClust, axis=0)    #mean��ƽ��
    end
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
