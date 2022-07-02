% ��������Ϊ��ȡͼ��ĵ�Ƶ���󡢸�Ƶ����
%-----------------����--------------------
%img:����ͼ��
%L:��ȡ��Ƶ�����ĵ���ͶӰ����
%P:��ȡ��Ƶ�����ĵ���ͶӰ����
%unit:���С
%is_overlap:�Ƿ��ص�
%stride:ȡ�鲽��
%w_num:�����ϱ��ֿ�ĸ���
%-----------------���--------------------
%I_b:��Ƶ��������ԭͼ��Сһ��
%I_d:��Ƶ��������ԭͼ��Сһ��
%I_d_v:ϸ��ʸ������
%count_matric:��¼�ص�������
%I_vector:�����������ڻ��ƻ�õĹ۲�ԭʼ����
function [I_b, I_d, I_d_v, count_matric, I_vector] = vector_decomposition(img, L, P, unit, is_overlap, stride, w_num)
% lrr parts and salient parts
% stride = 4;
% image, using reflecting to resize input image
[t1,t2] = size(img);
h = t1;
w = t2;
s = stride;

% figure;imshow(img_or);
% figure;imshow(img);

% salient parts by latlrr
I_d = zeros(h, w);
I_b = zeros(h, w);
% the matrices for overlapping
count_matric = zeros(h, w);
ones_matric = ones(unit,unit);

c1 = 0;
for i=1:s:h-unit+1
    c2 = 0;
    c1 = c1+1;
    for j=1:s:w-unit+1
        c2 = c2+1;
        temp = img(i:(i+unit-1), j:(j+unit-1));
        temp_vector(:,(c1-1)*(w_num)+c2) = temp(:);
        % record the overlapping number
        count_matric(i:(i+unit-1), j:(j+unit-1)) =...
                count_matric(i:(i+unit-1), j:(j+unit-1)) + ones_matric(:, :);
    end
end
img_vector = temp_vector;
I_vector = img_vector;

% calculate features
I_d_v = L*temp_vector;
I_b_v = P*temp_vector;

%reshape features
c1 = 0;
for ii=1:s:h-unit+1
    c2 = 0;
    c1 = c1+1;
    for jj=1:s:w-unit+1
        c2 = c2+1;
        temp = I_d_v(:, (c1-1)*(w_num)+c2);
        I_d(ii:(ii+unit-1), jj:(jj+unit-1)) = I_d(ii:(ii+unit-1), jj:(jj+unit-1)) + reshape(temp, [unit unit]);
    end
end
% average operation for overlapping position
I_d = I_d./count_matric;

% base parts
c1 = 0;
for ii=1:s:h-unit+1
    c2 = 0;
    c1 = c1+1;
    for jj=1:s:w-unit+1
        c2 = c2+1;
        temp = I_b_v(:, (c1-1)*(w_num)+c2);
        I_b(ii:(ii+unit-1), jj:(jj+unit-1)) = I_b(ii:(ii+unit-1), jj:(jj+unit-1)) + reshape(temp, [unit unit]);
    end
end
% average operation for overlapping position
I_b = I_b./count_matric;

end