clear
clc
dbstop if error
I = imread('Tiffany.tiff');
Origin_I = double(I); 
%% 随机生成嵌入的数据
num = 2100000; %秘密数据的长度
rand('seed',0);
Data = round(rand(1,num)*1);
%% 图像预处理
block_size = 3;
load('PE_bitplane2')
[Process_bitplane2,tag,f,recover_start_ubx,recover_start_uby,finalem_x1,finalem_y1] = rerrange(PE_bitplane2,block_size);