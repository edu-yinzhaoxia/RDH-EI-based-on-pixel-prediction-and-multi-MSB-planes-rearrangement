function [Encrypt_I] = Encrypt_image(Process_I,Image_key,final_emUBdata,f,tag_preprocess,block_size)
%ENCRYPT_IMAGE 此处显示有关此函数的摘要
% final_emUBdata(在UB中嵌入秘密信息的坐标),f(NUB的个数)
[row,col] = size(Process_I);
%% 根据密钥生成与origin_I大小相同的随机矩阵
rand('seed',Image_key); %设置种子
E = round(rand(row,col)*255); %随机生成row*col矩阵
%% 加密的8个矩阵
 E_bitplane1 = zeros(row,col);E_bitplane2 = zeros(row,col);E_bitplane3 = zeros(row,col);E_bitplane4 = zeros(row,col);
 E_bitplane5 = zeros(row,col);E_bitplane6 = zeros(row,col);E_bitplane7 = zeros(row,col);E_bitplane8 = zeros(row,col);
 bin = zeros(1,8);
 for i=1:row
    for j=1:col
           bin = Decimalism_Binary(E(i,j)); %越界像素无法用7位表示，要用8位
           E_bitplane1(i,j)= bin(1);E_bitplane2(i,j)= bin(2);E_bitplane3(i,j)= bin(3);E_bitplane4(i,j)= bin(4);
           E_bitplane5(i,j)= bin(5);E_bitplane6(i,j)= bin(6);E_bitplane7(i,j)= bin(7);E_bitplane8(i,j)= bin(8); 
    end
 end
%% 将预处理图像分为8个位平面
Encrypt_bitplane1 = ones(row,col)*Inf;Encrypt_bitplane2 = ones(row,col)*Inf;Encrypt_bitplane3 = ones(row,col)*Inf;Encrypt_bitplane4 = ones(row,col)*Inf;
Encrypt_bitplane5 = ones(row,col)*Inf;Encrypt_bitplane6 = ones(row,col)*Inf;Encrypt_bitplane7 = ones(row,col)*Inf;Encrypt_bitplane8 = ones(row,col)*Inf;
Process_bitplane1=Encrypt_bitplane1;Process_bitplane2=Encrypt_bitplane2;Process_bitplane3=Encrypt_bitplane3;Process_bitplane4=Encrypt_bitplane4;
Process_bitplane5=Encrypt_bitplane5;Process_bitplane6=Encrypt_bitplane6;Process_bitplane7=Encrypt_bitplane7;Process_bitplane8=Encrypt_bitplane8;
bin2=zeros(1,8);
for i=1:row
  for j=1:col
        value=Process_I(i,j);
       [bin2] = Decimalism_Binary(value);
        Process_bitplane1(i,j) =  bin2(1);
        Process_bitplane2(i,j) =  bin2(2);
        Process_bitplane3(i,j) =  bin2(3);
        Process_bitplane4(i,j) =  bin2(4);
        Process_bitplane5(i,j) =  bin2(5);
        Process_bitplane6(i,j) =  bin2(6);
        Process_bitplane7(i,j) =  bin2(7);
        Process_bitplane8(i,j) =  bin2(8);
  end
end
%% 加密预处理图像的8个位平面 
if tag_preprocess(1)==1 %如果当前为平面是可嵌入的位平面，那么NUB全部加密，就要UB要从没有嵌入辅助信息的位置开始嵌入
    %NUB加密
      f1=f(1);
      finalem_x1=final_emUBdata(1,1);
      finalem_y1=final_emUBdata(1,2);
      [encrypt_bitplane1] =encrypt_NUB(f1,Process_bitplane1,block_size,E_bitplane1);
      [final_enbitplane1] = encrypt_UB(encrypt_bitplane1,E_bitplane1,finalem_x1,finalem_y1,block_size);  
else
    [final_enbitplane1] = encrypt_All(Process_bitplane1,E_bitplane1,block_size);
end
%------------------------------------%
if tag_preprocess(2)==1
    %NUB加密
      f2=f(2);
      finalem_x2=final_emUBdata(2,1);
      finalem_y2=final_emUBdata(2,2);
      [encrypt_bitplane2] =encrypt_NUB(f2,Process_bitplane2,block_size,E_bitplane2);
      [final_enbitplane2] = encrypt_UB(encrypt_bitplane2,E_bitplane2,finalem_x2,finalem_y2,block_size);  
else
    [final_enbitplane2] = encrypt_All(Process_bitplane2,E_bitplane2,block_size);
end
%------------------------------------%
if tag_preprocess(3)==1
    %NUB加密
      f3=f(3);
      finalem_x3=final_emUBdata(3,1);
      finalem_y3=final_emUBdata(3,2);
      [encrypt_bitplane3] =encrypt_NUB(f3,Process_bitplane3,block_size,E_bitplane3);
      [final_enbitplane3] = encrypt_UB(encrypt_bitplane3,E_bitplane3,finalem_x3,finalem_y3,block_size);  
else
    [final_enbitplane3] = encrypt_All(Process_bitplane3,E_bitplane3,block_size);
end
%------------------------------------%
if tag_preprocess(4)==1
    %NUB加密
      f4=f(4);
      finalem_x4=final_emUBdata(4,1);
      finalem_y4=final_emUBdata(4,2);
      [encrypt_bitplane4] =encrypt_NUB(f4,Process_bitplane4,block_size,E_bitplane4);
      [final_enbitplane4] = encrypt_UB(encrypt_bitplane4,E_bitplane4,finalem_x4,finalem_y4,block_size);  
else
    [final_enbitplane4] = encrypt_All(Process_bitplane4,E_bitplane4,block_size);
end
%------------------------------------%
if tag_preprocess(5)==1
    %NUB加密
      f5=f(5);
      finalem_x5=final_emUBdata(5,1);
      finalem_y5=final_emUBdata(5,2);
      [encrypt_bitplane5] =encrypt_NUB(f5,Process_bitplane5,block_size,E_bitplane5);
      [final_enbitplane5] = encrypt_UB(encrypt_bitplane5,E_bitplane5,finalem_x5,finalem_y5,block_size);  
else
    [final_enbitplane5] = encrypt_All(Process_bitplane5,E_bitplane5,block_size);
end
%------------------------------------%
if tag_preprocess(6)==1
    %NUB加密
      f6=f(6);
      finalem_x6=final_emUBdata(6,1);
      finalem_y6=final_emUBdata(6,2);
      [encrypt_bitplane6] =encrypt_NUB(f6,Process_bitplane6,block_size,E_bitplane6);
      [final_enbitplane6] = encrypt_UB(encrypt_bitplane6,E_bitplane6,finalem_x6,finalem_y6,block_size);  
else
    [final_enbitplane6] = encrypt_All(Process_bitplane6,E_bitplane6,block_size);
end
%------------------------------------%
if tag_preprocess(7)==1
    %NUB加密
      f7=f(7);
      finalem_x7=final_emUBdata(7,1);
      finalem_y7=final_emUBdata(7,2);
      [encrypt_bitplane7] =encrypt_NUB(f7,Process_bitplane7,block_size,E_bitplane7);
      [final_enbitplane7] = encrypt_UB(encrypt_bitplane7,E_bitplane7,finalem_x7,finalem_y7,block_size);  
else
    [final_enbitplane7] = encrypt_All(Process_bitplane7,E_bitplane7,block_size);
    %------------------------------------%
if tag_preprocess(8)==1
    %NUB加密
      f8=f(8);
      finalem_x8=final_emUBdata(8,1);
      finalem_y8=final_emUBdata(8,2);
      [encrypt_bitplane8] =encrypt_NUB(f8,Process_bitplane8,block_size,E_bitplane8);
      [final_enbitplane8] = encrypt_UB(encrypt_bitplane8,E_bitplane8,finalem_x8,finalem_y8,block_size);  
else
    [final_enbitplane8] = encrypt_All(Process_bitplane8,E_bitplane8,block_size);
end
end
[Encrypt_I] = eight_to_one(final_enbitplane1,final_enbitplane2,final_enbitplane3,final_enbitplane4,final_enbitplane5,final_enbitplane6,final_enbitplane7,final_enbitplane8);
end




function [encrypt_bitplane1] =encrypt_NUB(f1,Process_bitplane1,block_size,E_bitplane1)
%函数输入：tag_NUB1(判断位平面NUB的可嵌情况),Stego_bitplane1,fnub(NUB块数),Data(秘密信息),emnub_t(Data里嵌入秘密信息的坐标)
%函数输出：next_emnub_t(下一个NUB位平面开始嵌入的Data坐标),tag_NUB1(判断位平面NUB的可嵌情况，保留后方便压缩)
%%
[row,col] = size(Process_bitplane1); %统计图像的行列数
block_m = floor(row/block_size);  %分块大小为block_size*block_size
block_n = floor(col/block_size);  %分块个数为block_m*block_n，每行有block_m个分块
encrypt_bitplane1=Process_bitplane1;

%% 加密NUB
startx=1;
starty=1;
for k=1:f1
    for i=0:block_size-1
        for j=0:block_size-1
           vx = startx + i;
           vy = starty + j;
           encrypt_bitplane1(vx,vy) = bitxor(Process_bitplane1(vx,vy),E_bitplane1(vx,vy) );
        end
    end
    if vy==block_n*block_size && mod(vx,block_size)==0 && vx~=block_m*block_size %若嵌入到每行的倒数第二列（因为预测像素不嵌入）,且不在最后一行
          startx = vx + 1; %换到下一行
          starty = 1;
    else
          starty = vy + 1;
    end
    if vy==block_n*block_size && vx==block_m*block_size
           break;
    end
end

end
function [final_enbitplane1] = encrypt_UB(encrypt_bitplane1,E_bitplane1,finalem_x,finalem_y,block_size)
%% 在UBs中嵌入秘密数据 

[row,col] = size(encrypt_bitplane1);

block_m = floor(row/block_size);  %分块大小为block_size*block_size
block_n = floor(col/block_size);  %分块个数为block_m*block_n，每行有block_m个分块
% ftypeI = ceil(block_m*block_n/(block_size*block_size-1)); %嵌入typeI的UB块数 %这三句新加上去
final_enbitplane1 = encrypt_bitplane1;

startx_encrypt = finalem_x; %UB中嵌入秘密数据的开始坐标
starty_encrypt = finalem_y;
%% 加密

for t=1:(row*col)
       for p=0:block_size-1
          for q=0:block_size-1
                 vx = startx_encrypt + p;
                 vy = starty_encrypt + q;
                 final_enbitplane1(vx,vy) = bitxor( encrypt_bitplane1(vx,vy),E_bitplane1(vx,vy) );
          end
       end
       if vy==block_n*block_size && mod(vx,block_size)==0 && vx~=block_m*block_size %若嵌入到每行的倒数第二列（因为预测像素不嵌入）,且不在最后一行
          startx_encrypt = vx + 1; %换到下一行
          starty_encrypt = 1;
       else
          starty_encrypt = vy + 1;
       end
       if vy==block_n*block_size && vx==block_m*block_size
           break;
       end

end %至此，是从没有嵌入typeI的UB块中开始嵌入

end
function [final_enbitplane1] = encrypt_All(Process_bitplane1,E_bitplane1,block_size)
%% 在UBs中嵌入秘密数据 

[row,col] = size(Process_bitplane1);

block_m = floor(row/block_size);  %分块大小为block_size*block_size
block_n = floor(col/block_size);  %分块个数为block_m*block_n，每行有block_m个分块
% ftypeI = ceil(block_m*block_n/(block_size*block_size-1)); %嵌入typeI的UB块数 %这三句新加上去
final_enbitplane1 = Process_bitplane1;

startx_encrypt = 1; %UB中嵌入秘密数据的开始坐标
starty_encrypt = 1;
%% 加密

for t=1:(row*col)
       for p=0:block_size-1
          for q=0:block_size-1
                 vx = startx_encrypt + p;
                 vy = starty_encrypt + q;
                 final_enbitplane1(vx,vy) = bitxor( Process_bitplane1(vx,vy),E_bitplane1(vx,vy) );
          end
       end
       if vy==block_n*block_size && mod(vx,block_size)==0 && vx~=block_m*block_size %若嵌入到每行的倒数第二列（因为预测像素不嵌入）,且不在最后一行
          startx_encrypt = vx + 1; %换到下一行
          starty_encrypt = 1;
       else
          starty_encrypt = vy + 1;
       end
       if vy==block_n*block_size && vx==block_m*block_size
           break;
       end

end %至此，是从没有嵌入typeI的UB块中开始嵌入

end

