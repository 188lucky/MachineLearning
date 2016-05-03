function [ result ] = PolynomialKernel( data,c,d )
%����ʽ�˺���
%   dataԭʼ���ݣ���Ϊ��������Ϊά��
%   cΪ������
%   dΪ�ݴ�
%   result���ع�ϵ����

[m,~] = size(data);
result = zeros(m);
for i=1:m
    for j=i:m
        result(i,j) = (data(i,:) * data(j,:)' + c)^d;
        result(j,i) = result(i,j);
    end
end

end

