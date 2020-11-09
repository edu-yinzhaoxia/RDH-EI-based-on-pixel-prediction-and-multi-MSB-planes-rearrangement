function [emNUBD,num_NUBD,num_NUBD_every,final_Stego1,final_Stego2,final_Stego3,final_Stego4,final_Stego5,final_Stego6,final_Stego7,final_Stego8] = Embed_NUBdata(block_size,num_emubD,Data,tag_preprocess,f,Stego_bitplane1,Stego_bitplane2,Stego_bitplane3,Stego_bitplane4,Stego_bitplane5,Stego_bitplane6,Stego_bitplane7,Stego_bitplane8,tag_NUB1,tag_NUB2,tag_NUB3,tag_NUB4,tag_NUB5,tag_NUB6,tag_NUB7,tag_NUB8)
% 函数输入：num_emubD（UB中嵌入信息的个数）,Data,tag_preprocess,f,tag_NUB1
% 函数输出：
end_emnub_t = num_emubD;
final_Stego1=Stego_bitplane1;final_Stego2=Stego_bitplane2;final_Stego3=Stego_bitplane3;final_Stego4=Stego_bitplane4;
final_Stego5=Stego_bitplane5;final_Stego6=Stego_bitplane6;final_Stego7=Stego_bitplane7;final_Stego8=Stego_bitplane8;
num_NUBD1=0;num_NUBD2=0;num_NUBD3=0;num_NUBD4=0;
num_NUBD5=0;num_NUBD6=0;num_NUBD7=0;num_NUBD8=0; %每个位平面的NUB嵌入信息数量
if tag_preprocess(1)==1
   emnub_t = num_emubD;
%    f1=f(1);
   [final_Stego1,end_emnub_t] = Embed_onebitplane_NUBdata(tag_NUB1,Stego_bitplane1,Data,emnub_t,block_size);
   num_NUBD1= end_emnub_t - num_emubD;
end
if tag_preprocess(2)==1
   emnub_t = end_emnub_t;
%    f2=f(2);
   [final_Stego2,end_emnub_t] = Embed_onebitplane_NUBdata(tag_NUB2,Stego_bitplane2,Data,emnub_t,block_size); 
   num_NUBD2=end_emnub_t - num_emubD - num_NUBD1;
end
if tag_preprocess(3)==1
   emnub_t = end_emnub_t;
%    f3=f(3);
   [final_Stego3,end_emnub_t] = Embed_onebitplane_NUBdata(tag_NUB3,Stego_bitplane3,Data,emnub_t,block_size); 
   num_NUBD3=end_emnub_t - num_emubD - num_NUBD1 - num_NUBD2;
end
if tag_preprocess(4)==1
    emnub_t = end_emnub_t;
%    f4=f(4);
   [final_Stego4,end_emnub_t] = Embed_onebitplane_NUBdata(tag_NUB4,Stego_bitplane4,Data,emnub_t,block_size); 
   num_NUBD4=end_emnub_t - num_emubD - num_NUBD1 - num_NUBD2 - num_NUBD3;
end
if tag_preprocess(5)==1
    emnub_t = end_emnub_t;
%    f5=f(5);
   [final_Stego5,end_emnub_t] = Embed_onebitplane_NUBdata(tag_NUB5,Stego_bitplane5,Data,emnub_t,block_size);
   num_NUBD5=end_emnub_t - num_emubD - num_NUBD1 - num_NUBD2 - num_NUBD3 - num_NUBD4;
end
if tag_preprocess(6)==1
    emnub_t = end_emnub_t;
%    f6=f(6);
   [final_Stego6,end_emnub_t] = Embed_onebitplane_NUBdata(tag_NUB6,Stego_bitplane6,Data,emnub_t,block_size); 
   num_NUBD6=end_emnub_t - num_emubD - num_NUBD1 - num_NUBD2 - num_NUBD3 - num_NUBD4 - num_NUBD5;
end
if tag_preprocess(7)==1
   emnub_t = end_emnub_t;
%    f7=f(7);
   [final_Stego7,end_emnub_t] = Embed_onebitplane_NUBdata(tag_NUB7,Stego_bitplane7,Data,emnub_t,block_size); 
   num_NUBD7=end_emnub_t - num_emubD - num_NUBD1 - num_NUBD2 - num_NUBD3 - num_NUBD4 - num_NUBD5 - num_NUBD6;
end
if tag_preprocess(8)==1
   emnub_t = end_emnub_t;
%    f8=f(8);
   [final_Stego8,end_emnub_t] = Embed_onebitplane_NUBdata(tag_NUB8,Stego_bitplane8,Data,emnub_t,block_size); 
   num_NUBD8=end_emnub_t - num_emubD - num_NUBD1 - num_NUBD2 - num_NUBD3 - num_NUBD4 - num_NUBD5 - num_NUBD6 - num_NUBD7;
end
num_emNUBD = end_emnub_t;
emNUBD = Data(num_emubD+1:num_emNUBD);%嵌入在NUB理的信息

num_NUBD = num_emNUBD-num_emubD;  %嵌入在NUB的信息数

num_NUBD_every=zeros(1,8); %统计每个位平面，NUB里嵌入信息的个数
num_NUBD_every(1)=num_NUBD1;num_NUBD_every(2)=num_NUBD2;num_NUBD_every(3)=num_NUBD3;num_NUBD_every(4)=num_NUBD4;
num_NUBD_every(5)=num_NUBD5;num_NUBD_every(6)=num_NUBD6;num_NUBD_every(7)=num_NUBD7;num_NUBD_every(8)=num_NUBD8;

end

function [final_Stego1,next_emnub_t] = Embed_onebitplane_NUBdata(tag_NUB1,Stego_bitplane1,Data,emnub_t,block_size)
%函数输入：tag_NUB1(判断位平面NUB的可嵌情况),Stego_bitplane1,fnub(NUB块数),Data(秘密信息),emnub_t(Data里嵌入秘密信息的坐标)
%函数输出：next_emnub_t(下一个NUB位平面开始嵌入的Data坐标),tag_NUB1(判断位平面NUB的可嵌情况，保留后方便压缩)
%%
[row,col] = size(Stego_bitplane1); %统计图像的行列数
block_m = floor(row/block_size);  %分块大小为block_size*block_size
block_n = floor(col/block_size);  %分块个数为block_m*block_n，每行有block_m个分块
final_Stego1=Stego_bitplane1;

%% 嵌入信息
num_NUB=length(tag_NUB1);
startx1 = 1;starty1 = 3;
startx2 = 2;starty2 = 1;
startx3 = 3;starty3 = 4;
startx4 = 4;starty4 = 2;
% emnub_t=1;
for i=1:num_NUB
    if tag_NUB1(i)==0 % NUB的标记是0，则可嵌入
        final_Stego1(startx1,starty1) = Data(emnub_t+1);  %emnub_t是上次嵌入的终止位，所以这次嵌入要加1
        final_Stego1(startx2,starty2) = Data(emnub_t+2);
        final_Stego1(startx3,starty3) = Data(emnub_t+3);
        final_Stego1(startx4,starty4) = Data(emnub_t+4);
        emnub_t=emnub_t+4;
    end
    if starty1 + block_size > block_n*block_size  %若遍历到每行最后一个NUB块，则纵坐标变为下一行第一个块的第一个嵌入位置的纵坐标，横坐标向下移动block_size个像素
        startx1 = startx1 + block_size;
        starty1 = starty1 - (block_n-1)*block_size;
    else
        starty1 = starty1 + block_size;
    end
    if starty2 + block_size > block_n*block_size  %若遍历到每行最后一个NUB块，则纵坐标变为下一行第一个块的第一个嵌入位置的纵坐标，横坐标向下移动block_size个像素
        startx2 = startx2 + block_size;
        starty2 = starty2 - (block_n-1)*block_size;
    else
        starty2 = starty2 + block_size;
    end
    if starty3 + block_size > block_n*block_size  %若遍历到每行最后一个NUB块，则纵坐标变为下一行第一个块的第一个嵌入位置的纵坐标，横坐标向下移动block_size个像素
        startx3 = startx3 + block_size;
        starty3 = starty3 - (block_n-1)*block_size;
    else
        starty3 = starty3 + block_size;
    end
    if starty4 + block_size > block_n*block_size  %若遍历到每行最后一个NUB块，则纵坐标变为下一行第一个块的第一个嵌入位置的纵坐标，横坐标向下移动block_size个像素
        startx4 = startx4 + block_size;
        starty4 = starty4 - (block_n-1)*block_size;
    else
        starty4 = starty4 + block_size;
    end
end
next_emnub_t=emnub_t;
end

