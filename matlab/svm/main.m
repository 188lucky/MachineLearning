clear;
clc;
dataOri =load('data.txt');
n = length(dataOri);%����������
dataSet = dataOri(:,1:3);
dataSet=dataSet/(max(max(abs(dataSet)))-min(min(abs(dataSet))));
labels = dataOri(:,4);%����־
labels(labels==0) = -1;
sigma=0.1;        %��˹�˺���
C = 2;

svm_train=dataSet(2:2:end,:);
svm_train_labels=labels(2:2:end,:);

%svmѵ��
[wt,alpha,b]=svm(svm_train,svm_train_labels,sigma,C);
% [wt,alpha,b]=svm(dataSet,labels,sigma,C);

y=wt*dataSet'+b;

labelsnew=zeros(n,1);
for i = 1 : n
    if y(i)  < 0
        labelsnew(i)=1;
    else 
        labelsnew(i)=2;
    end
end

labels(labels==-1) = 2;

