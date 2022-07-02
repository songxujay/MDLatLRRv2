%   Í¼Ïñ»¯Í¼Ïñ¿é
%----------ÊäÈë--------
%B_detail:Ï¸½ÚÍ¼Ïñ¿éÊ¸Á¿»¯¾ØÕó
%B_smooth:¹â»¬Í¼Ïñ¿éÊ¸Á¿»¯¾ØÕó
%unit:Í¼Ïñ¿é´óĞ¡
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

