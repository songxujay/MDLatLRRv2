% 函数功能为求取图像的低频矩阵、高频矩阵
%-----------------输入--------------------
%img:输入图像
%L:提取高频特征的低秩投影矩阵
%P:提取低频特征的低秩投影矩阵
%unit:块大小
%is_overlap:是否重叠
%stride:取块步长
%w_num:横向上被分块的个数
%-----------------输出--------------------
%I_b:低频特征，与原图大小一致
%I_d:高频特征，与原图大小一致
%I_d_v:细节矢量矩阵
%count_matric:记录重叠数矩阵
%I_vector:经过滑动窗口机制获得的观测原始矩阵
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