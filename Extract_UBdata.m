function [exUB_Data,exUB_numData] = Extract_UBdata(tag_preprocess,num_emubD,final_emUBdata,block_size,final_Stego1,final_Stego2,final_Stego3,final_Stego4,final_Stego5,final_Stego6,final_Stego7,final_Stego8)
%函数输入：tag_preprocess(位平面可嵌标记),num_emubD(UB中嵌入DATA总数),final_emUBdata(UB中嵌入信息的开始坐标),block_size,
%函数输出：exUB_Data(UB中提取的数据),exUB_numData(UB中提取数据总数)
%函数描述：
if tag_preprocess(1)==1
%    num_extract1=ex_end_UB_t1;
   finalem_UBx1=final_emUBdata(1,1);
   finalem_UBy1=final_emUBdata(1,2);
   % fnub=f(1);
   [exUBD1,ex_end_UB_t1] = extract(final_Stego1,num_emubD,finalem_UBx1,finalem_UBy1,block_size);
else
    exUBD1=0;
    ex_end_UB_t1=0; %第一提取数后，DATA停留的终止坐标
end
if tag_preprocess(2)==1
%    num_extract2=ex_end_UB_t1; %上个位平面提取的DATA终止坐标
   finalem_UBx2=final_emUBdata(2,1);
   finalem_UBy2=final_emUBdata(2,2);
   % fnub=f(1);
   [exUBD2,ex_end_UB_t2] = extract(final_Stego2,num_emubD,finalem_UBx2,finalem_UBy2,block_size); 
else
    exUBD2=0;
    ex_end_UB_t2=0; %第二次提取数据后data停留的终止坐标
end
if tag_preprocess(3)==1
%    num_extract3=ex_end_UB_t2; %上个位平面提取的DATA终止坐标
   finalem_UBx3=final_emUBdata(3,1);
   finalem_UBy3=final_emUBdata(3,2);
   [exUBD3,ex_end_UB_t3] = extract(final_Stego3,num_emubD,finalem_UBx3,finalem_UBy3,block_size); 
else
    exUBD3=0;
    ex_end_UB_t3=0;
end
if tag_preprocess(4)==1
%    num_extract4=ex_end_UB_t3; %上个位平面提取的DATA终止坐标
   finalem_UBx4=final_emUBdata(4,1);
   finalem_UBy4=final_emUBdata(4,2);
   [exUBD4,ex_end_UB_t4] = extract(final_Stego4,num_emubD,finalem_UBx4,finalem_UBy4,block_size); 
else
    exUBD4=0;
    ex_end_UB_t4=0;
end
if tag_preprocess(5)==1
%    num_extract5=ex_end_UB_t4; %上个位平面提取的DATA终止坐标
   finalem_UBx5=final_emUBdata(5,1);
   finalem_UBy5=final_emUBdata(5,2);
   [exUBD5,ex_end_UB_t5] = extract(final_Stego5,num_emubD,finalem_UBx5,finalem_UBy5,block_size); 
else
    exUBD5=0;
    ex_end_UB_t5=0;
end
if tag_preprocess(6)==1
%    num_extract6=ex_end_UB_t5; %上个位平面提取的DATA终止坐标
   finalem_UBx6=final_emUBdata(6,1);
   finalem_UBy6=final_emUBdata(6,2);
   [exUBD6,ex_end_UB_t6] = extract(final_Stego6,num_emubD,finalem_UBx6,finalem_UBy6,block_size); 
else
    exUBD6=0;
    ex_end_UB_t6=0;
end
if tag_preprocess(7)==1
%    num_extract7=ex_end_UB_t6; %上个位平面提取的DATA终止坐标
   finalem_UBx7=final_emUBdata(7,1);
   finalem_UBy7=final_emUBdata(7,2);
   [exUBD7,ex_end_UB_t7] = extract(final_Stego7,num_emubD,finalem_UBx7,finalem_UBy7,block_size); 
else
    exUBD7=0;
    ex_end_UB_t7=0;
end
if tag_preprocess(8)==1
   finalem_UBx8=final_emUBdata(8,1);
   finalem_UBy8=final_emUBdata(8,2);
   [exUBD8,ex_end_UB_t8] = extract(final_Stego8,num_emubD,finalem_UBx8,finalem_UBy8,block_size); 
else
    exUBD8=0;
    ex_end_UB_t8=0;
end
exUB_numData=ex_end_UB_t1++ex_end_UB_t2+ex_end_UB_t3+ex_end_UB_t4+ex_end_UB_t5+ex_end_UB_t6+ex_end_UB_t7+ex_end_UB_t8;

exUBD1=exUBD1(1:ex_end_UB_t1);exUBD2=exUBD2(1:ex_end_UB_t2);exUBD3=exUBD3(1:ex_end_UB_t3);exUBD4=exUBD4(1:ex_end_UB_t4);
exUBD5=exUBD5(1:ex_end_UB_t5);exUBD6=exUBD6(1:ex_end_UB_t6);exUBD7=exUBD7(1:ex_end_UB_t7);exUBD8=exUBD8(1:ex_end_UB_t8);
m=0;
for i=1:8
    if tag_preprocess(i)==1
        m=m+1;
    end %统计可以嵌入位平面的个数       
end
if m==1 %将可以提取数据的位平面，提取的数据合并
    exUB_Data=exUBD1;
elseif m==2
    exUB_Data=[exUBD1,exUBD2];
elseif m==3
    exUB_Data=[exUBD1,exUBD2,exUBD3];
elseif m==4
    exUB_Data=[exUBD1,exUBD2,exUBD3,exUBD4];
elseif m==5
    exUB_Data=[exUBD1,exUBD2,exUBD3,exUBD4,exUBD5];
elseif m==6
    exUB_Data=[exUBD1,exUBD2,exUBD3,exUBD4,exUBD5,exUBD6];
elseif m==7
    exUB_Data=[exUBD1,exUBD2,exUBD3,exUBD4,exUBD5,exUBD6,exUBD7];
else
    exUB_Data=[exUBD1,exUBD2,exUBD3,exUBD4,exUBD5,exUBD6,exUBD7,exUBD8];
end


end

function [exUBD,exUB_t] = extract(final_Stego1,num_emubD,finalem_UBx,finalem_UBy,block_size)
[row,col] = size(final_Stego1); %统计图像的行列数
block_m = floor(row/block_size);  %分块大小为block_size*block_size
block_n = floor(col/block_size);  %分块个数为block_m*block_n，共有有block_m行分块，block_n列分块
% ftypeI = ceil(block_m*block_n/(block_size*block_size-1)); %嵌入typeI的UB块数

exUBD = ones(1,num_emubD)*Inf; %创建全零一维数组，长度等于UB嵌入数据长度
exUB_t = 0; %记录每个位平面提取出的数据个数，

startUB_x = finalem_UBx; %从UB中提取数据的开始坐标
startUB_y = finalem_UBy;
%% 从UB中提取数据
for t=1:num_emubD 
       for p=0:block_size-1
          for q=0:block_size-1
             if p==block_size-1 && q==block_size-1
                 break;
             else
                 exUB_t = exUB_t+1;
                 vx = startUB_x + p;
                 vy = startUB_y + q;
                 exUBD(exUB_t)= final_Stego1(vx,vy);
             end
          end
       end
       if vy==block_n*block_size-1 && mod(vx,block_size)==0 && vx~=block_m*block_size %若嵌入到每行的倒数第二列（因为预测像素不嵌入）,且不在最后一行
          startUB_x = vx + 1; %换到下一行
          startUB_y = 1;
       else
          startUB_y = vy + 2;
       end
       if vy==block_n*block_size-1 && vx==block_m*block_size
           break;
       end
end 
end

