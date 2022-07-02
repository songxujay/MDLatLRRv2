%函数功能为返回图像的低频矩阵、高频矩阵
%-----------------输入--------------------
%img:输入图像
%de_level:分解层数
%L:提取高频特征的低秩投影矩阵
%P:提取低频特征的低秩投影矩阵
%unit:块大小
%is_overlap:是否重叠
%stride:取块步长
%w_num:横向上被分块的个数
%-----------------输出--------------------
%I_b_deep:经过分解后得到的低频特征，与原图大小一致
%I_d_deep:经过分解后得到的高频矢量矩阵，用于融合
%show_matrix:用于存储高频特征，与原图大小一致
%count_all:记录重叠数矩阵
%I_vector:经过滑动窗口机制获得的观测原始矩阵
function [I_b_deep,I_d_deep, show_matrix, count_all, I_vector] = vector_deep_latent(img, de_level, L, P, unit, is_overlap, stride, w_num)

[t1,t2] = size(img);
show_matrix = [];
% I_d = zeros(t1,t2,de_level);
I_b_deep = zeros(t1,t2);
for i=1:de_level
    if i==1
        [temp_b, temp_d, temp_d_v, count_m, I_vector] = vector_decomposition(img, L, P, unit, is_overlap, stride, w_num);
    else
        [temp_b, temp_d, temp_d_v, count_m, I_vector] = vector_decomposition(temp_b, L, P, unit, is_overlap, stride, w_num);
    end
    I_d_deep(:,:,i) = temp_d_v(:,:);
    show_matrix = cat(2,show_matrix, temp_d);
    
%     imwrite(temp_d,['./fused_vector/features/salient_level_',num2str(i),'.png'],'png');
%     imwrite(temp_b,['./fused_vector/features/base_level_',num2str(i),'.png'],'png');
    
end
% show_matrix = cat(2,show_matrix, temp_b);
% figure;imshow(show_matrix);
% imwrite(temp_b,['./fused_vector/features/base_level_',num2str(i),'.png'],'png');
% imwrite(temp_b,['./fused_vector/features/base_level_',num2str(i),'.png'],'png');
I_b_deep(:,:) = temp_b(:,:);
count_all = count_m;
% I_d_deep = I_d;

end