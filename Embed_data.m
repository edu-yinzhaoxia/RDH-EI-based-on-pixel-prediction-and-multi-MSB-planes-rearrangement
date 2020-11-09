function [emubD,num_emubD,num_em_ub,Stego_bitplane1,Stego_bitplane2,Stego_bitplane3,Stego_bitplane4,Stego_bitplane5,Stego_bitplane6,Stego_bitplane7,Stego_bitplane8] = Embed_data(Encrypt_I,block_size,Data,num,tag_preprocess,final_emUBdata,f)
% 函数说明：嵌入数据
% 输入参数：Data（秘密数据），num(秘密数据的总量),tag_preprocess（标记是否可嵌），finalem（每个位平面嵌入的开始坐标）
% 输出参数：emubD(UB中嵌入的秘密数据),num_emubD(所有位平面UB嵌入秘密信息总数),num_em_ub(每个位平面UB嵌入秘密信息数),
start_d = 0;
start_d2 =0;
%% 加密图像分为8个位平面
[row,col] = size(Encrypt_I);
 Process_bitplane1 = zeros(row,col);Process_bitplane2 = zeros(row,col);Process_bitplane3 = zeros(row,col);Process_bitplane4 = zeros(row,col);
 Process_bitplane5 = zeros(row,col);Process_bitplane6 = zeros(row,col);Process_bitplane7 = zeros(row,col);Process_bitplane8 = zeros(row,col);
 bin = zeros(1,8);
 for i=1:row
    for j=1:col
           bin = Decimalism_Binary(Encrypt_I(i,j)); %越界像素无法用7位表示，要用8位
           Process_bitplane1(i,j)= bin(1);Process_bitplane2(i,j)= bin(2);Process_bitplane3(i,j)= bin(3);Process_bitplane4(i,j)= bin(4);
           Process_bitplane5(i,j)= bin(5);Process_bitplane6(i,j)= bin(6);Process_bitplane7(i,j)= bin(7);Process_bitplane8(i,j)= bin(8); 
    end
 end
%%
Stego_bitplane1=Process_bitplane1;Stego_bitplane2=Process_bitplane2;Stego_bitplane3=Process_bitplane3;Stego_bitplane4=Process_bitplane4;
Stego_bitplane5=Process_bitplane5;Stego_bitplane6=Process_bitplane6;Stego_bitplane7=Process_bitplane7;Stego_bitplane8=Process_bitplane8;
num_em_ub1=0;num_em_ub2=0;num_em_ub3=0;num_em_ub4=0;
num_em_ub5=0;num_em_ub6=0;num_em_ub7=0;num_em_ub8=0;
if tag_preprocess(1)==1
   start_d = start_d2;
   finalem_x1=final_emUBdata(1,1);
   finalem_y1=final_emUBdata(1,2);
   f1=f(1);
   [Stego_bitplane1,start_d2] = embed(Process_bitplane1,Data,num,start_d,f1,finalem_x1,finalem_y1,block_size); 
   num_em_ub1=start_d2;
end
if tag_preprocess(2)==1
   start_d = start_d2;
   finalem_x2=final_emUBdata(2,1);
   finalem_y2=final_emUBdata(2,2);
   f2=f(2);
   [Stego_bitplane2,start_d2] = embed(Process_bitplane2,Data,num,start_d,f2,finalem_x2,finalem_y2,block_size);   
   num_em_ub2=start_d2-num_em_ub1;
end
if tag_preprocess(3)==1
   start_d = start_d2;
   finalem_x3=final_emUBdata(3,1);
   finalem_y3=final_emUBdata(3,2);
   f3=f(3);
   [Stego_bitplane3,start_d2] = embed(Process_bitplane3,Data,num,start_d,f3,finalem_x3,finalem_y3,block_size); 
   num_em_ub3=start_d2-num_em_ub2-num_em_ub1;
end
if tag_preprocess(4)==1
    start_d = start_d2;
   finalem_x4=final_emUBdata(4,1);
   finalem_y4=final_emUBdata(4,2);
   f4=f(4);
   [Stego_bitplane4,start_d2] = embed(Process_bitplane4,Data,num,start_d,f4,finalem_x4,finalem_y4,block_size);
   num_em_ub4=start_d2-num_em_ub3-num_em_ub2-num_em_ub1;
end
if tag_preprocess(5)==1
    start_d = start_d2;
   finalem_x5=final_emUBdata(5,1);
   finalem_y5=final_emUBdata(5,2);
   f5=f(5);
   [Stego_bitplane5,start_d2] = embed(Process_bitplane5,Data,num,start_d,f5,finalem_x5,finalem_y5,block_size);
   num_em_ub5=start_d2-num_em_ub4-num_em_ub3-num_em_ub2-num_em_ub1;
end
if tag_preprocess(6)==1
    start_d = start_d2;
   finalem_x6=final_emUBdata(6,1);
   finalem_y6=final_emUBdata(6,2);
   f6=f(6);
   [Stego_bitplane6,start_d2] = embed(Process_bitplane6,Data,num,start_d,f6,finalem_x6,finalem_y6,block_size);
   num_em_ub6=start_d2-num_em_ub5-num_em_ub4-num_em_ub3-num_em_ub2-num_em_ub1;
end
if tag_preprocess(7)==1
   start_d = start_d2;
   finalem_x7=final_emUBdata(7,1);
   finalem_y7=final_emUBdata(7,2);
   f7=f(7);
   [Stego_bitplane7,start_d2] = embed(Process_bitplane7,Data,num,start_d,f7,finalem_x7,finalem_y7,block_size);
   num_em_ub7=start_d2-num_em_ub6-num_em_ub5-num_em_ub4-num_em_ub3-num_em_ub2-num_em_ub1;
end
if tag_preprocess(8)==1
   start_d = start_d2;
   finalem_x8=final_emUBdata(8,1);
   finalem_y8=final_emUBdata(8,2);
   f8=f(8);
   [Stego_bitplane8,start_d2] = embed(Process_bitplane8,Data,num,start_d,f8,finalem_x8,finalem_y8,block_size);
   num_em_ub8=start_d2-num_em_ub7-num_em_ub6-num_em_ub5-num_em_ub4-num_em_ub3-num_em_ub2-num_em_ub1;
end
num_emubD = start_d2;
emubD = Data(1:num_emubD);

num_em_ub=zeros(1,8);%每个位平面UB可以嵌入的秘密数据的个数，统计
num_em_ub(1)=num_em_ub1;num_em_ub(2)=num_em_ub2;num_em_ub(3)=num_em_ub3;num_em_ub(4)=num_em_ub4;
num_em_ub(5)=num_em_ub5;num_em_ub(6)=num_em_ub6;num_em_ub(7)=num_em_ub7;num_em_ub(8)=num_em_ub8;
end

function [Stego_bitplane1,start_d2] = embed(Process_bitplane1,Data,num,start_d,f,finalem_x,finalem_y,block_size)
%% 在UBs中嵌入秘密数据 
start_d2 = start_d; %秘密数据一维数组的下标
[row,col] = size(Process_bitplane1);

block_m = floor(row/block_size);  %分块大小为block_size*block_size
block_n = floor(col/block_size);  %分块个数为block_m*block_n，每行有block_m个分块
% ftypeI = ceil(block_m*block_n/(block_size*block_size-1)); %嵌入typeI的UB块数 %这三句新加上去


Stego_bitplane1 = Process_bitplane1;
num_D = length(Data);
startx_emdata = finalem_x; %UB中嵌入秘密数据的开始坐标
starty_emdata = finalem_y;

for t=1:num
%    if start_d2<num_D %循环退不出去！！%当扫描到可以嵌入秘密数据的UB时(F是NUB的数目，ftypeI是嵌入typeI的UB块数); 且嵌入数量小于总共的秘密数据数量
       for p=0:block_size-1
          for q=0:block_size-1
             if p==block_size-1 && q==block_size-1
                 break;
             else
                 start_d2 = start_d2+1;
                 vx = startx_emdata + p;
                 vy = starty_emdata + q;
                 Stego_bitplane1(vx,vy) = Data(start_d2);
             end
          end
       end
       if vy==block_n*block_size-1 && mod(vx,block_size)==0 && vx~=block_m*block_size %若嵌入到每行的倒数第二列（因为预测像素不嵌入）,且不在最后一行
          startx_emdata = vx + 1; %换到下一行
          starty_emdata = 1;
       else
          starty_emdata = vy + 2;
       end
       if vy==block_n*block_size-1 && vx==block_m*block_size
           break;
       end
end %至此，是从没有嵌入typeI的UB块中开始嵌入

end