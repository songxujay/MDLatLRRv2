%������
clear
clc

disp('----------main------------');
% load matrices
load('./models/MD_L_16_detail_mix_2000_s1000.mat');
load('./models/MD_P_16_detail_mix_2000_s1000.mat');
L = L_16;
P = P_16;

%�����ں�ͼ�����ͽ����ں�
fusion_all_kinds( 'CT_MR', P, L )
fusion_all_kinds( 'MR_PET', P, L )
fusion_all_kinds( 'MR_SPECT', P, L )






