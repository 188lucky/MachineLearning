clear;%����
clc;
% dataOri =load('data.txt');
% n = length(dataOri);%����������
% dataSet = dataOri(:,1:3);
% labels = dataOri(:,4);%����־
% labels(labels==0) = -1;

load('Flame.mat');
dataSet = Flame;
n = length(dataSet);%����������
% labels = dataOri(:,4);%����־
% labels(labels==0) = -1;

sigma=1;        %��˹�˺���
TOL = 0.0001;   %����Ҫ��
C = 1;          %����������ʧ������Ȩ��
b = 0;          %��ʼ���ýؾ�b
Wold = 0;       %δ����aʱ��W(a)
Wnew = 0;       %����a���W(a)

a = ones(n,1)*0.2;  %����a

%��˹�˺�����������
W=pdist(dataSet);
W=squareform(W);
W = -W.^2/(2*sigma*sigma);
W = full(spfun(@exp, W));
for i=1:n
    W(i,i)=1;
end

sum=(a.*labels)'*W;

while 1 %��������
    
    %����ʽѡ��
    n1 = 1;%��ʼ����n1,n2����ѡ���2����
    n2 = 2;
    %n1���յ�һ��Υ��KKT�����ĵ�ѡ��
    while n1 <= n
        if labels(n1) * (sum(n1) + b) == 1 && a(n1) >= C && a(n1) <=  0
            break;
        end
        if labels(n1) * (sum(n1) + b) > 1 && a(n1) ~=  0
            break;
        end
        if labels(n1) * (sum(n1) + b) < 1 && a(n1) ~=C
            break;
        end
        n1 = n1 + 1;
    end
    
    
    %n2�������|E1-E2|��ԭ��ѡȡ
    E1 = 0;
    E2 = 0;
    maxDiff = 0;%�����������
    E1 = sum(n1) + b - labels(n1);%n1�����
    for i = 1 : n
        tempSum = sum(i) + b - labels(i);
        if abs(E1 - tempSum)> maxDiff
            maxDiff = abs(E1 - tempSum);
            n2 = i;
            E2 = tempSum;
        end
    end
    
    
    %���½��и���
    a1old = a(n1);
    a2old = a(n2);
    KK = W(n1,n1) + W(n2,n2) - 2*W(n1,n2);
    a2new = a2old + labels(n2) *(E1 - E2) / KK;%�����µ�a2
    
    %a2��������Լ������
    S = labels(n1) * labels(n2);
    if S == -1
        U = max(0,a2old - a1old);
        V = min(C,C - a1old + a2old);
    else
        U = max(0,a1old + a2old - C);
        V = min(C,a1old + a2old);
    end
    if a2new > V
        a2new = V;
    end
    if a2new < U
        a2new = U;
    end
    a1new = a1old + S * (a2old - a2new);%�����µ�a1
    a(n1) = a1new;%����a
    a(n2) = a2new;
    
    %���²���ֵ
    sum = zeros(n,1);
    for k = 1 : n
        for i = 1 : n
            sum(k) = sum(k) + a(i) * labels(i) * W(i,k);
        end
    end
    Wold = Wnew;
    Wnew = 0;%����a���W(a)
    tempSum = 0;%��ʱ����
    for i = 1 : n
        for j = 1 : n
            tempSum= tempSum + labels(i )*labels(j)*a(i)*a(j)*W(i,j);
        end
        Wnew= Wnew+ a(i);
    end
    Wnew= Wnew - 0.5 * tempSum;
    
    
    %���¸���b��ͨ���ҵ�ĳһ��֧������������
    support = 1;%֧�����������ʼ��
    while abs(a(support))< 1e-4 && support <= n
        support = support + 1;
    end
    b = 1 / labels(support) - sum(support);
    
    
    %�ж�ֹͣ����
    if abs(Wnew/ Wold - 1 ) <= TOL
        break;
    end
end

%������������ԭ���࣬�������������svm������
% for i = 1 : n
%     fprintf('��%d��:ԭ��� ',i);
%     if i <= 50
%         fprintf('-1');
%     else
%         fprintf(' 1');
%     end
%     fprintf('    �б���ֵ%f      ������',sum(i) + b);
%     if abs(sum(i) + b - 1) < 0.5
%         fprintf('1\n');
%     else if abs(sum(i) + b + 1) < 0.5
%             fprintf('-1\n');
%         else
%             fprintf('�������\n');
%         end
%     end
% end

result=zeros(n,1);
%������������ԭ���࣬�������������svm������
for i = 1 : n
    if abs(sum(i) + b - 1) < 0.5
        result(i)=2;
    else
        result(i)=1;
    end
end

% labels(labels==-1)=2;
% result(result==-1)=2;

score=nmi(labels,result);