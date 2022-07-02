%根据融合图像类型，对应进行融合
%----------输入----------
%type:融合图像类型
%P:用于提取低频特征的低秩投影矩阵
%L:用于提取高频特征的低秩投影矩阵
function  fusion_all_kinds( type, P, L)

    is_overlap = 1;

    % parameters setting
    stride_cell = {1,2,4,6,8,10,12,14}; % for 16*16. In our paper is 1.
    [n_s, m_s] = size(stride_cell);
    L_cell = {'8', '16'}; % projecting matrix. In our paper is 16.
    [n_L, m_L] = size(L_cell);
    level_cell = {1,2,3,4,5,6,7,8,9,10}; % decomposition level. In our paper is 1 to 4.
    [n_le, m_le] = size(level_cell);

    for s=1:1
        stride = stride_cell{s}; %stride=1
        norm = 'nu';%融合策略
        %%%%% 8, 16 %%%%%%%%%%%%%%%
        for k=2:m_L
    %             eval(['L = L_', L_cell{k}, ';'])
            unit = str2double(L_cell{k});
            % decomposition level 1 - 8
            for jj=1:4%1:4
                de_level = level_cell{jj};
                str_t = ['L_',L_cell{k},'; level: ',num2str(de_level), '_',norm, '_', '; stride: ', num2str(stride)];
                disp(str_t);
                t = 0;
                for j=11:30 %11：30
                    index = j;
                    path1 = ['./test_images/', type, '/',num2str(index),'-1','.jpg'];
                    path2 = ['./test_images/', type, '/',num2str(index),'-2','.jpg'];
                    if is_overlap == 1
                        path_temp = ['./fused_p_s/', type ,'/', 'level_', num2str(de_level), '/'];
                        if exist(path_temp,'dir')==0
                            mkdir(path_temp);
                        end
                        fuse_path = [path_temp, 'fused',num2str(index), '_p_s_level_',num2str(de_level), '_',norm ,'_stride_',num2str(stride),'.png'];
                    end
                    if exist(fuse_path,'file')~=0
                        continue;
                    end
                    % Fusion
                    img1 = imread(path1);
                    img2 = imread(path2);

                    if size(img1,1)~= 256
                        img1=imresize(img1,[256,256]);
                    end
                    if size(img2,1)~= 256
                        img2=imresize(img2,[256,256]);
                    end

                    if size(img1,3)>1
                        img1 = rgb2gray(img1);
    %                         imwrite(img1,['./fused_vector/features/image','.png'],'png');
                    end

    %                     img1 = im2double(img1);
    %                     img2 = im2double(img2);
                    img1 = double(img1)/255;
                    img2 = double(img2)/255;
                    img2_YUV=ConvertRGBtoYUV(img2);
                    img1_gray=img1;
                    img2_gray=img2_YUV(:,:,1);
                    [h,w] = size(img1);
                    tic 
                    F = vector_fusion_method(img1_gray, img2_gray, L, P,unit, de_level, norm, is_overlap, stride);
                    imgf_YUV1=zeros(h,w,3);
                    imgf_YUV1(:,:,1)=F;
                    imgf_YUV1(:,:,2)=img2_YUV(:,:,2);
                    imgf_YUV1(:,:,3)=img2_YUV(:,:,3);
                    imgf_RGB=ConvertYUVtoRGB(imgf_YUV1);
                    result = uint8(imgf_RGB*255);
                    str_o = [str_t, '; index: ', num2str(index), '; time: ', num2str(toc)];
                    disp(str_o);
                    imwrite(result,fuse_path,'png');
                end
            end
        end
    end
end

