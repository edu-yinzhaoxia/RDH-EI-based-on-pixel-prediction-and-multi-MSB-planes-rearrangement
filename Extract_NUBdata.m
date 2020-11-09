function [exNUB_Data,exNUB_numData] = Extract_NUBdata(tag_preprocess,num_NUBD,block_size,tag_NUB1,tag_NUB2,tag_NUB3,tag_NUB4,tag_NUB5,tag_NUB6,tag_NUB7,tag_NUB8,final_Stego1,final_Stego2,final_Stego3,final_Stego4,final_Stego5,final_Stego6,final_Stego7,final_Stego8)
%函数输入：tag_preprocess(位平面可嵌标记),num_NUBD(NUB中嵌入DATA总数),tag_NUB1(当前位平面NUB可嵌标记)，final_Stego1
%函数输出：
%函数说明：将可嵌的位平面NUB中信息提取
if tag_preprocess(1)==1
    [exNUBD1,exNUB_t1] = extract_NUB(final_Stego1,num_NUBD,tag_NUB1,block_size);
else
    exNUBD1=0;exNUB_t1=0;
end
if tag_preprocess(2)==1
    [exNUBD2,exNUB_t2] = extract_NUB(final_Stego2,num_NUBD,tag_NUB2,block_size);
else
    exNUBD2=0;exNUB_t2=0;
end
if tag_preprocess(3)==1
    [exNUBD3,exNUB_t3] = extract_NUB(final_Stego3,num_NUBD,tag_NUB3,block_size);
else
    exNUBD3=0;exNUB_t3=0;
end
if tag_preprocess(4)==1
    [exNUBD4,exNUB_t4] = extract_NUB(final_Stego4,num_NUBD,tag_NUB4,block_size);
else
    exNUBD4=0;exNUB_t4=0;
end
if tag_preprocess(5)==1
    [exNUBD5,exNUB_t5] = extract_NUB(final_Stego5,num_NUBD,tag_NUB5,block_size);
else
    exNUBD5=0;exNUB_t5=0;
end
if tag_preprocess(6)==1
    [exNUBD6,exNUB_t6] = extract_NUB(final_Stego6,num_NUBD,tag_NUB6,block_size);
else
    exNUBD6=0;exNUB_t6=0;
end
if tag_preprocess(7)==1
    [exNUBD7,exNUB_t7] = extract_NUB(final_Stego7,num_NUBD,tag_NUB7,block_size);
else
    exNUBD7=0;exNUB_t7=0;
end
if tag_preprocess(8)==1
    [exNUBD8,exNUB_t8] = extract_NUB(final_Stego8,num_NUBD,tag_NUB8,block_size);
else
    exNUBD8=0;exNUB_t8=0;
end
exNUB_numData = exNUB_t1+exNUB_t2+exNUB_t3+exNUB_t4+exNUB_t5+exNUB_t6+exNUB_t7+exNUB_t8;%所以位平面NUB提取信息总数
exNUBD1=exNUBD1(1:exNUB_t1);exNUBD2=exNUBD2(1:exNUB_t2);exNUBD3=exNUBD3(1:exNUB_t3);exNUBD4=exNUBD4(1:exNUB_t4);
exNUBD5=exNUBD5(1:exNUB_t5);exNUBD6=exNUBD6(1:exNUB_t6);exNUBD7=exNUBD7(1:exNUB_t7);exNUBD8=exNUBD8(1:exNUB_t8);
m=0;
for i=1:8
    if tag_preprocess(i)==1
        m=m+1;
    end %统计可以嵌入位平面的个数(即可提取位平面个数)       
end
if m==1
    exNUB_Data=exNUBD1;
elseif m==2
    exNUB_Data=[exNUBD1,exNUBD2];
elseif m==3
    exNUB_Data=[exNUBD1,exNUBD2,exNUBD3];
elseif m==4
    exNUB_Data=[exNUBD1,exNUBD2,exNUBD3,exNUBD4];
elseif m==5
    exNUB_Data=[exNUBD1,exNUBD2,exNUBD3,exNUBD4,exNUBD5];
elseif m==6
    exNUB_Data=[exNUBD1,exNUBD2,exNUBD3,exNUBD4,exNUBD5,exNUBD6];
elseif m==7
    exNUB_Data=[exNUBD1,exNUBD2,exNUBD3,exNUBD4,exNUBD5,exNUBD6,exNUBD7];
else
    exNUB_Data=[exNUBD1,exNUBD2,exNUBD3,exNUBD4,exNUBD5,exNUBD6,exNUBD7,exNUBD8];
end


end


function [exNUBD1,exNUB_t1] = extract_NUB(final_Stego1,num_NUBD,tag_NUB1,block_size)
[row,col] = size(final_Stego1); %统计图像的行列数
block_m = floor(row/block_size);  %分块大小为block_size*block_size
block_n = floor(col/block_size);  %分块个数为block_m*block_n，每行有block_m个分块

num_tagNUB=length(tag_NUB1);
exNUBD1=ones(1,num_NUBD)*Inf; %不会全部装满，因为num_NUBD是所有位平面NUB可嵌入的信息数
exNUB_t1=0; %当前位平面提取出数据的个数

startx1 = 1;starty1 = 3;
startx2 = 2;starty2 = 1;
startx3 = 3;starty3 = 4;
startx4 = 4;starty4 = 2;
for i=1:num_tagNUB %NUB的个数，是循环的次数
    if tag_NUB1(i)==0 % NUB的标记是0，则可嵌入(0多，比较好压缩)
        exNUBD1(exNUB_t1+1)=final_Stego1(startx1,starty1) ;  %emnub_t是上次嵌入的终止位，所以这次嵌入要加1
        exNUBD1(exNUB_t1+2)=final_Stego1(startx2,starty2) ; 
        exNUBD1(exNUB_t1+3)=final_Stego1(startx3,starty3) ; 
        exNUBD1(exNUB_t1+4)=final_Stego1(startx4,starty4) ; 
        exNUB_t1=exNUB_t1+4;
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

end
