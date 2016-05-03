function [wt,alpha,b]=svm(dataSet,labels,sigma,C)
% ������svm
% ����  : dataSet       : ���ݼ�
%        labels         ������
%        sigma          : ��˹�˺���,sigmaֵ
%        C              : ����������ʧ������Ȩ��
%
% ���  : alpha : 
%         b��     �ؾ�

    [n,m]=size(dataSet);%����������
    
    wt=zeros(1,m);

    TOL = 0.0001;   %����Ҫ��
    b = 0;          %��ʼ���ýؾ�b
    Wnew = 0;       %����a���W(a)

    alpha = ones(n,1)*C/2;  %����a�������ʼ��a,a����[0,C]

    %��˹�˺�����������
    K=kernelTrans(dataSet,sigma);

    sum=(alpha.*labels)'*K;

    while 1
        %����ʽѡ�㣬n1,n2����ѡ���2����
        n1 = 1;
        n2 = 2;
        %n1����һ��Υ��KKT�����ĵ�ѡ��
        while n1 <= n
            if labels(n1) * (sum(n1) + b) == 1 && alpha(n1) >= C && alpha(n1) <=  0
                break;
            end
            if labels(n1) * (sum(n1) + b) > 1 && alpha(n1) ~=  0
                break;
            end
            if labels(n1) * (sum(n1) + b) < 1 && alpha(n1) ~=C
                break;
            end
            n1 = n1 + 1;
        end

        %n2�������|E1-E2|��ԭ��ѡȡ
        E2 = 0;
        maxDiff = 0;%�����������
        E1 = sum(n1) + b - labels(n1);%n1�����
        for i = 1 : n
            tempW = sum(i) + b - labels(i);
            if abs(E1 - tempW)> maxDiff
                maxDiff = abs(E1 - tempW);
                n2 = i;
                E2 = tempW;
            end
        end

        %���½��и���
        a1old = alpha(n1);
        a2old = alpha(n2);
        KK = K(n1,n1) + K(n2,n2) - 2*K(n1,n2);
        a2new = a2old + labels(n2) *(E1 - E2) / KK;

        yy=labels(n1) * labels(n2);
        if yy==-1
            L=max(0,a2old - a1old);
            H=min(C,C + a2old - a1old );
        else
            L=max(0,a1old + a2old - C);
            H=min(C,a1old + a2old);
        end

        a2new=min(a2new,H);
        a2new=max(a2new,L);
        a1new = a1old + yy * (a2old - a2new);
        wt=wt+labels(n1)*(a1new-a1old)*dataSet(i,:)+labels(n2)*(a2new-a2old)*dataSet(n2,:);
%         ai_new = a(i) + y(i) * y(j) * (a(j) - aj_clip);
%        w = w + y(i) * (ai_new - a(i)) * x(i,:) + y(j) * (aj_clip - a(j)) * x(j,:);

        %����a
        alpha(n1) = a1new;
        alpha(n2) = a2new;

        %����Ei��b
        sum=(alpha.*labels)'*K;

        Wold = Wnew;
        Wnew = 0;%����a���W(a)
        tempW=0;
        for i = 1 : n
            for j = 1 : n
                tempW= tempW + labels(i )*labels(j)*alpha(i)*alpha(j)*K(i,j);
            end
            Wnew= Wnew+ alpha(i);
        end
        Wnew= Wnew - tempW/2;

        %���¸���b��ͨ���ҵ�ĳһ��֧������������
        bold=b;
        if a1new>=0 && a1new<=C
            b=(a1old-a1new)*labels(n1)*K(n1,n1)+(a2old-a2new)*labels(n2)*K(n2,n1)-E1+bold;
        elseif a2new>=0 && a2new<=C
            b=(a1old-a1new)*labels(n1)*K(n1,n2)+(a2old-a2new)*labels(n2)*K(n2,n2)-E2+bold;
        else      % (a1new<0||a1new>C)&&(a2new<0||a2new>C)
            b1=(a1old-a1new)*labels(n1)*K(n1,n1)+(a2old-a2new)*labels(n2)*K(n2,n1)-E1+bold;
            b2=(a1old-a1new)*labels(n1)*K(n1,n2)+(a2old-a2new)*labels(n2)*K(n2,n2)-E2+bold;
            b=(b1+b2)/2;
        end

        %�ж�ֹͣ����
        if abs(Wnew/ Wold - 1 ) <= TOL
            break;
        end
    end

end

function K = kernelTrans(dataSet,sigma)
    K=pdist(dataSet);
    K=squareform(K);
    K = -K.^2/(2*sigma*sigma);
    K=exp(K);
end  
