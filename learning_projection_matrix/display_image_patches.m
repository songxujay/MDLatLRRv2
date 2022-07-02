%   ͼ��ͼ���
%----------����--------
%B_detail:ϸ��ͼ���ʸ��������
%B_smooth:�⻬ͼ���ʸ��������
%unit:ͼ����С
function display_image_pathces( B_detail, B_smooth, unit )

[w1, h1] = size(B_detail);
[w2, h2] = size(B_smooth);

for i=1:h1
    temp = B_detail(:,i);
    temp = imresize(temp,[unit,unit]);
    path = ['./patches/', num2str(unit), '/detail/'];
    if exist(path,'dir')==0
        mkdir(path);
    end
    save_path = [path, num2str(i), '.jpg'];
    imwrite(temp, save_path,'jpg');
end

for i=1:h2
    temp = B_smooth(:,i);
    temp = imresize(temp,[unit,unit]);
    path = ['./patches/', num2str(unit), '/smooth/'];
    if exist(path,'dir')==0
        mkdir(path);
    end
    save_path = [path, num2str(i), '.jpg'];
    imwrite(temp, save_path,'jpg');
end


end

