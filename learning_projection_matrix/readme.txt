train_projection_matrices.m--------训练低秩投影矩阵
train_choose_detail.m--------------采用滑动窗口机制将图像分块，并根据SD将图像块分类
train_latent_matrix------------------训练低秩投影矩阵P和L
latent_lrr----------------------------潜在低秩表示
display_image_pathces.m-----------图像化图像块

training_data------------------------训练数据集，CT,MRI,PET,SEPCT每种类型取10张，因此一共40张。来源http://www.escience.cn/people/xiaomi/index.html
patches------------------------------图像化图像块，程序运行时生成