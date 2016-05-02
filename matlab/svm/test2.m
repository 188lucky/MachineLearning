clear;%����
clc;
dataOri =load('data.txt');
n = length(dataOri);%����������
dataSet = dataOri(:,1:3);
dataSet=dataSet/(max(max(abs(dataSet)))-min(min(abs(dataSet))));
labels = dataOri(:,4);%����־
labels(labels==0) = -1;

sigma=1;
C=1;
b=0;

%�˺���
% K=zeros(n,n);
for i=1:n
    for j=1:n
        K{i,j}=exp((dataSet(i,:)-dataSet(j,:)).^2/(2*sigma.^2));
    end
end
% K=pdist(dataSet);
% K=squareform(K);
% K = -K.^2/(2*sigma.^2);
% K=exp(K);

alpha = ones(n,1)*C/2;  %����a�������ʼ��a,a����[0,C]

f=(alpha.*labels)'*K+b;

