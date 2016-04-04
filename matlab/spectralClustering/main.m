clc
clear
load('XOR.mat');
dataSet=XOR;
Z=pdist(dataSet);   %����ÿ������֮����룬���磺300���㣬300*299/2=44850����
W=squareform(Z);    %���Ӿ���
k=4;    %

C = spectral(W, k);

[m,n]=size(dataSet);

plot(dataSet(C==1,1),dataSet(C==1,2),'ro', dataSet(C==2,1),dataSet(C==2,2),'bo', dataSet(C==3,1),dataSet(C==3,2),'go', dataSet(C==4,1),dataSet(C==4,2),'mo');

% for i=1:m
% 	if C(i, 1)==1
%          plot(dataSet(i,1),dataSet(i,2),'bo');
%          hold on;
%      elseif C(i, 1)==2
%      	plot(dataSet(i,1),dataSet(i,2),'ro');
%          hold on;
%     elseif C(i, 1)==3
%      	plot(dataSet(i,1),dataSet(i,2),'go');
%          hold on;
%      else 
%          plot(dataSet(i,1),dataSet(i,2),'mo');
%          hold on;
%  	end
% end
