%训练低秩投影矩阵P和L
%------------输入------------
%B:细节图像块
%B_smooth:光滑图像块
%col:训练集包含图像块的总个数
%col_smo:训练图像块中包含光滑图像块个数
%------------输出------------
%L:训练得到的低秩投影矩阵，用于提取图像的高频信息
%P:训练得到的低秩投影矩阵，用于提取图像的低频信息
function [L,P] = train_latent_matrix(B, B_smooth, col, col_smo)
% Train the extractor of salient features 'L'
%   min_Z,L,E ||Z||_* + ||L||_* +　lambda||E||_1,
%           s.t. X = XZ + LX +E.

[s1_d, s2_d] = size(B);
[s1_s, s2_s] = size(B_smooth);
B_d = B(:,randperm(s2_d, col-col_smo));
B_s = B_smooth(:,randperm(s2_s, col_smo));
B_rand = cat(2,B_d, B_s);
B_rand = B_rand(:, randperm(col));

lambda = 0.4;
disp('Start-latent lrr');
disp('It takes almost 10 min.');
tic
[Z,L,E] = latent_lrr(B_rand,lambda);
%得到Z之后，
Tr_lr=B_rand*Z; % train_data就是X，Tr_lr是主成分（XZ）
[U, s, V] = svd(B_rand,'econ'); 
svp = find(diag(s) > 0);
pseudo_xt = V(:, svp) * inv(s(svp, svp)) *  U(:, svp)';
P = Tr_lr * pseudo_xt;
toc
disp('Done-latent lrr');

end




