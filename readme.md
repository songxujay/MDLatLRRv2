This original implementation of this paper: [arxiv](https://arxiv.org/abs/2206.15179)

main.m----------------------------主函数

fusion_all_kinds.m-----------------根据融合图像类型，对应进行融合

ConvertRGBtoYUV.m-------------将彩色图像(RGB)转换为YUV空间

ConvertYUVtoRGB.m-------------将YUV转换为RGB空间

fusion_base_parts.m--------------融合低频特征

vector_fusion_method.m---------返回融合结果

vector_fusion_detail_parts.m-----融合细节特征

vector_deep_latent.m-------------返回图像的低频、高频矩阵

vector_decomposition.m---------求取图像的低频、高频矩阵

test_images-----------------------测试数据文件夹

models----------------------------存储低秩投影矩阵文件夹

learning_projection_matrix--------学习低秩投影矩阵程序

fused_p_s--------------------------存储融合结果文件夹，主函数运行时，自动生成
