function [centroids,clusterAssment,dataSet]=kMeansPathbased(dataSet,k)
    m=size(dataSet,1);
    clusterAssment = zeros(m,2);    %m��2��ȫ�����,�����洢�ط����������У�һ�м�¼������ֵ����һ�д洢����ǰ�㵽�����ĵľ��룩
    centroids = randCent(dataSet, k);
    clusterChanged = true;
    while clusterChanged
        clusterChanged = false;
        for i=1:m
            minDist=Inf;
            minIndex=-1;
            for j=1:k
                distJI=distEclud(centroids(j,:),dataSet(i,:));   %�������
                if distJI < minDist
                    minDist = distJI;
                    minIndex = j;
                end
            end
            if clusterAssment(i,1)~=minIndex
                clusterChanged = true;
            end
            clusterAssment(i,1) = minIndex;
            clusterAssment(i,2) = minDist^2;
        end
        for cent=1:k
            avgx=0;
            avgy=0;
            count=0;
            for t=1:m
                if clusterAssment(t,1)==cent
                    avgx=avgx+dataSet(t,1);
                    avgy=avgy+dataSet(t,2);
                    count=count+1;
                end
            end
            if count~=0
                avgx=avgx/count;
                avgy=avgy/count;
            end
            centroids(cent,1)=avgx;
            centroids(cent,2)=avgy;
        end
    end
end

%��������֮�����
function dist=distEclud(vecA, vecB)
    vecSum=(vecA(1,:)-vecB(1,:)).^2;
    dist=sqrt(vecSum(:,1)+vecSum(:,2));
end

function centroids=randCent(dataSet,k)
    n=size(dataSet,2);    % m:���x�ж�����   n:���x�ж�����
    centroids=zeros(k,n);
    for j=1:n
       minJ=min(dataSet(:,j));  %��j�����ֵ
       maxJ=max(dataSet(:,j));  %��j����Сֵ
       rangeJ=maxJ-minJ;
       centroids(:,j)=minJ+rangeJ*rand(k,1);    %�������������Ϊ�ص�����
    end
end
