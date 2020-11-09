function [recover_bitplane1,recover_bitplane2,recover_bitplane3,recover_bitplane4,recover_bitplane5,recover_bitplane6,recover_bitplane7,recover_bitplane8] = Recover_image1(Decrypt_I,compress_type_len,tag_preprocess,recover_start_ub,block_size,typeI1,typeI2,typeI3,typeI4,typeI5,typeI6,typeI7,typeI8,tag_NUB1,tag_NUB2,tag_NUB3,tag_NUB4,tag_NUB5,tag_NUB6,tag_NUB7,tag_NUB8,final_Stego1,final_Stego2,final_Stego3,final_Stego4,final_Stego5,final_Stego6,final_Stego7,final_Stego8)
%函数输入：compress_type_len(每个位平面压缩后的type数量),tag_preprocess(判断当前位平面是否进行了调整),recover_start_ub(UB恢复的坐标),tag_NUB1(判断哪些NUB需要恢复)
%函数输出：
%函数说明：
[row,col] = size(Decrypt_I);
%% 将解密后的图像分为八个位平面
decrypt_bitplane1 = ones(row,col)*Inf;decrypt_bitplane2 = ones(row,col)*Inf;decrypt_bitplane3 = ones(row,col)*Inf;decrypt_bitplane4 = ones(row,col)*Inf;
decrypt_bitplane5 = ones(row,col)*Inf;decrypt_bitplane6 = ones(row,col)*Inf;decrypt_bitplane7 = ones(row,col)*Inf;decrypt_bitplane8 = ones(row,col)*Inf;
bin2=zeros(1,8);
for i=1:row
  for j=1:col
        value=Decrypt_I(i,j);
        [bin2] = Decimalism_Binary(value);
        decrypt_bitplane1(i,j) =  bin2(1);
        decrypt_bitplane2(i,j) =  bin2(2);
        decrypt_bitplane3(i,j) =  bin2(3);
        decrypt_bitplane4(i,j) =  bin2(4);
        decrypt_bitplane5(i,j) =  bin2(5);
        decrypt_bitplane6(i,j) =  bin2(6);
        decrypt_bitplane7(i,j) =  bin2(7);
        decrypt_bitplane8(i,j) =  bin2(8);
  end
end
%% 
recover_bitplane1=decrypt_bitplane1;recover_bitplane2=decrypt_bitplane2;recover_bitplane3=decrypt_bitplane3;recover_bitplane4=decrypt_bitplane4;
recover_bitplane5=decrypt_bitplane5;recover_bitplane6=decrypt_bitplane6;recover_bitplane7=decrypt_bitplane7;recover_bitplane8=decrypt_bitplane8;

if tag_preprocess(1)==1
   recover_start_ubx1=recover_start_ub(1,1); %开始恢复UB的坐标
   recover_start_uby1=recover_start_ub(1,2);
   compress_type_len1=compress_type_len(1);
   [recover_bitplane1] = recover_onebitplane(typeI1,compress_type_len1,block_size,tag_NUB1,recover_start_ubx1,recover_start_uby1,decrypt_bitplane1);
end
if tag_preprocess(2)==1
   recover_start_ubx2=recover_start_ub(2,1); %开始恢复UB的坐标
   recover_start_uby2=recover_start_ub(2,2);
   compress_type_len2=compress_type_len(2);
   [recover_bitplane2] = recover_onebitplane(typeI2,compress_type_len2,block_size,tag_NUB2,recover_start_ubx2,recover_start_uby2,decrypt_bitplane2);
end
if tag_preprocess(3)==1
   recover_start_ubx3=recover_start_ub(3,1); %开始恢复UB的坐标
   recover_start_uby3=recover_start_ub(3,2);
   compress_type_len3=compress_type_len(3);
   [recover_bitplane3] = recover_onebitplane(typeI3,compress_type_len3,block_size,tag_NUB3,recover_start_ubx3,recover_start_uby3,decrypt_bitplane3);
end
if tag_preprocess(4)==1
   recover_start_ubx4=recover_start_ub(4,1); %开始恢复UB的坐标
   recover_start_uby4=recover_start_ub(4,2);
   compress_type_len4=compress_type_len(4);
   [recover_bitplane4] = recover_onebitplane(typeI4,compress_type_len4,block_size,tag_NUB4,recover_start_ubx4,recover_start_uby4,decrypt_bitplane4);
end
if tag_preprocess(5)==1
   recover_start_ubx5=recover_start_ub(5,1); %开始恢复UB的坐标
   recover_start_uby5=recover_start_ub(5,2);
   compress_type_len5=compress_type_len(5);
   [recover_bitplane5] = recover_onebitplane(typeI5,compress_type_len5,block_size,tag_NUB5,recover_start_ubx5,recover_start_uby5,decrypt_bitplane5);
end
if tag_preprocess(6)==1
   recover_start_ubx6=recover_start_ub(6,1); %开始恢复UB的坐标
   recover_start_uby6=recover_start_ub(6,2);
   compress_type_len6=compress_type_len(6);
   [recover_bitplane6] = recover_onebitplane(typeI6,compress_type_len6,block_size,tag_NUB6,recover_start_ubx6,recover_start_uby6,decrypt_bitplane6);
end
if tag_preprocess(7)==1
   recover_start_ubx7=recover_start_ub(7,1); %开始恢复UB的坐标
   recover_start_uby7=recover_start_ub(7,2);
   compress_type_len7=compress_type_len(7);
   [recover_bitplane7] = recover_onebitplane(typeI7,compress_type_len7,block_size,tag_NUB7,recover_start_ubx7,recover_start_uby7,decrypt_bitplane7);
end
if tag_preprocess(8)==1
   recover_start_ubx8=recover_start_ub(8,1); %开始恢复UB的坐标
   recover_start_uby8=recover_start_ub(8,2);
   compress_type_len8=compress_type_len(8);
   [recover_bitplane8] = recover_onebitplane(typeI8,compress_type_len8,block_size,tag_NUB8,recover_start_ubx8,recover_start_uby8,decrypt_bitplane8);
end

end


function [recover_bitplane1] = recover_onebitplane(typeI,compress_type_len1,block_size,tag_NUB1,recover_start_ubx1,recover_start_uby1,final_Stego1)
%RECOVER_BIT2 此处显示有关此函数的摘要
%   此处显示详细说
[row,col] = size(final_Stego1); %统计图像的行列数
block_m = floor(row/block_size);  %分块大小为block_size*block_size
block_n = floor(col/block_size);  %分块个数为block_m*block_n，每行有block_m个分块

ftypeI_block = ceil(compress_type_len1/(block_size*block_size-1));%typeiage占用的4*4块数(1093块)
ftype_num = compress_type_len1; %typeimage元素总数
typeimage1=ones(1,ftype_num)*Inf; %创建装typeimage的容器

t=0; %typeimage的坐标
%% 提取typeimage
recover_x1=recover_start_ubx1;
recover_y1=recover_start_uby1;
for m=1:ftypeI_block
  for p=0:block_size-1
    for q=0:block_size-1
        if t== ftype_num %已经提取完typeimage了
            break;
        end
        if p~=block_size-1 || q~=block_size-1
            t=t+1;
            vx = recover_x1 + p;
            vy = recover_y1 + q;
            typeimage1(t)= final_Stego1(vx,vy);
        end 
    end
    if t== ftype_num  %已经提取完typeimage了
       break;
    end
  end
  if vy+1 == block_n*block_size
     recover_x1 = vx + 1;
     recover_y1 = 1;
  else
     recover_y1 = vy + 2;
  end 
end
%% 第二个位平面的UB
[row,col] = size(final_Stego1); %统计图像的行列数
block_m = floor(row/block_size);  %分块大小为block_size*block_size
block_n = floor(col/block_size);  %分块个数为block_m*block_n，每行有block_m个分块

UBx1 = recover_start_ubx1;
UBy1 = recover_start_uby1;
% ftype_num=block_m*block_n;
fnub1 = length(tag_NUB1); %NUB的个数
fub1 = block_m*block_n - fnub1; %UB的个数
recover_bitplane1 = final_Stego1; %恢复的位平面
for i = 1:fub1 
  for p=0:block_size-1
    for q=0:block_size-1
        px = final_Stego1(UBx1+block_size-1,UBy1+block_size-1);
        if p~=block_size-1 || q~=block_size-1
            vx = UBx1 + p;
            vy = UBy1 + q;
            recover_bitplane1(vx,vy) = px;
        end   
    end
  end
  if vy+1 == block_n*block_size
     UBx1 = vx + 1;
     UBy1 = 1;
  else
     UBy1 = vy + 2;
  end
end
%% 恢复NUB（不用提取压缩后的NUB，直接恢复）
startnub_x1 = 1;startnub_y1 = 3;
startnub_x2 = 2;startnub_y2 = 1;
startnub_x3 = 3;startnub_y3 = 4;
startnub_x4 = 4;startnub_y4 = 2;
for i = 1:fnub1
    if tag_NUB1(i)==0 % NUB的标记是0，则可嵌入
       if  (final_Stego1(startnub_x1,startnub_y1-1)+final_Stego1(startnub_x1+1,startnub_y1)+final_Stego1(startnub_x1,startnub_y1+1)==0) || (final_Stego1(startnub_x1,startnub_y1-1)+final_Stego1(startnub_x1+1,startnub_y1)+final_Stego1(startnub_x1,startnub_y1+1)==1)
           recover_bitplane1(startnub_x1,startnub_y1)=0; 
       else
           recover_bitplane1(startnub_x1,startnub_y1)=1;
       end
       if (final_Stego1(startnub_x2-1,startnub_y2)+final_Stego1(startnub_x2,startnub_y2+1)+final_Stego1(startnub_x2+1,startnub_y2)==0) || (final_Stego1(startnub_x2-1,startnub_y2)+final_Stego1(startnub_x2,startnub_y2+1)+final_Stego1(startnub_x2+1,startnub_y2)==1)
           recover_bitplane1(startnub_x2,startnub_y2)=0; 
       else
           recover_bitplane1(startnub_x2,startnub_y2)=1;  
       end
       if (final_Stego1(startnub_x3,startnub_y3-1)+final_Stego1(startnub_x3-1,startnub_y3)+final_Stego1(startnub_x3+1,startnub_y3)==0) || (final_Stego1(startnub_x3,startnub_y3-1)+final_Stego1(startnub_x3-1,startnub_y3)+final_Stego1(startnub_x3+1,startnub_y3)==1)
           recover_bitplane1(startnub_x3,startnub_y3)=0;
       else
           recover_bitplane1(startnub_x3,startnub_y3)=1;
       end
       if (final_Stego1(startnub_x4,startnub_y4-1)+final_Stego1(startnub_x4-1,startnub_y4)+final_Stego1(startnub_x4,startnub_y4+1)==0) || (final_Stego1(startnub_x4,startnub_y4-1)+final_Stego1(startnub_x4-1,startnub_y4)+final_Stego1(startnub_x4,startnub_y4+1)==1)
           recover_bitplane1(startnub_x4,startnub_y4)=0;
       else
           recover_bitplane1(startnub_x4,startnub_y4)=1;
       end
    end
    if startnub_y1 + block_size > block_n*block_size  %若遍历到每行最后一个NUB块，则纵坐标变为下一行第一个块的第一个嵌入位置的纵坐标，横坐标向下移动block_size个像素
        startnub_x1 = startnub_x1 + block_size;
        startnub_y1 = startnub_y1 - (block_n-1)*block_size;
    else
        startnub_y1 = startnub_y1 + block_size;
    end
    if startnub_y2 + block_size > block_n*block_size  %若遍历到每行最后一个NUB块，则纵坐标变为下一行第一个块的第一个嵌入位置的纵坐标，横坐标向下移动block_size个像素
        startnub_x2 = startnub_x2 + block_size;
        startnub_y2 = startnub_y2 - (block_n-1)*block_size;
    else
        startnub_y2 = startnub_y2 + block_size;
    end
    if startnub_y3 + block_size > block_n*block_size  %若遍历到每行最后一个NUB块，则纵坐标变为下一行第一个块的第一个嵌入位置的纵坐标，横坐标向下移动block_size个像素
        startnub_x3 = startnub_x3 + block_size;
        startnub_y3 = startnub_y3 - (block_n-1)*block_size;
    else
        startnub_y3 = startnub_y3 + block_size;
    end
    if startnub_y4 + block_size > block_n*block_size  %若遍历到每行最后一个NUB块，则纵坐标变为下一行第一个块的第一个嵌入位置的纵坐标，横坐标向下移动block_size个像素
        startnub_x4 = startnub_x4 + block_size;
        startnub_y4 = startnub_y4 - (block_n-1)*block_size;
    else
        startnub_y4 = startnub_y4 + block_size;
    end  
end
%% 重排恢复------------UB------------%
% typeI=reshape(typeimage1,block_n,block_m); %将一位数组转为col行row列 （因为reshape按列排序矩阵）
% typeI=typeI.'; %转置
start_ubx = recover_start_ubx1;
start_uby = recover_start_uby1;
beforebitplane=recover_bitplane1;
for i=1:block_m
   for j=1:block_n
        start_x = (i-1)*block_size + 1; %原始图像逐个扫描，每个分块的起始坐标
        start_y = (j-1)*block_size + 1;
%         if typeI(i,j) == 1  
        if typeI(i,j) == 0 
            ub_value =  beforebitplane(start_ubx+block_size-1,start_uby+block_size-1);                        %type image是1，即 UBs
            for x2 =0:block_size-1  %逐个从每个分块的起始坐标起算重排图像中NUBs的坐标,并将NUBs放到重排图像的上方
                for y2 = 0:block_size-1
                    vx = start_x + x2; %原始图像点的坐标
                    vy = start_y + y2;
                    recover_bitplane1(vx,vy) = ub_value;
                end
            end
             if start_uby+block_size > block_n*block_size  %若嵌入的UB达到每排最后一个，则坐标换到下一排
                 start_ubx = start_ubx + block_size;
                 start_uby = 1;
             else
                 start_uby = start_uby + block_size;
             end
        end
   end
end
%------------------NUB------------------------%
start_nubx=1;
start_nuby=1;
for i=1:block_m
  for j=1:block_n
        start_x = (i-1)*block_size + 1; %原始图像逐个扫描，每个分块的起始坐标
        start_y = (j-1)*block_size + 1;
%         if typeI(i,j) == 0       %type image是0，即 NUBs
        if typeI(i,j) == 1    
            for x=0:block_size-1  %逐个从每个分块的起始坐标起算重排图像中NUBs的坐标,并将NUBs放到重排图像的上方
                for y=0:block_size-1
                    vx = start_x + x; %原始图像点的坐标
                    vy = start_y + y;
                    nubx = start_nubx + x; %求重排图像中每个NUB分块中，各个像素点的坐标
                    nuby = start_nuby + y;
                    recover_bitplane1(vx,vy) =  beforebitplane(nubx,nuby);
                end
            end
            if nuby == block_n*block_size %若嵌入的NUB达到每排最后一个，则坐标换到下一排
                start_nubx = nubx + 1;
                start_nuby = 1;
            else
                start_nuby = nuby + 1;
            end
        end
  end
end
end