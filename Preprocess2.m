function [bin_NUB_len,final_emUBdata,tag_NUB1,tag_NUB2,tag_NUB3,tag_NUB4,tag_NUB5,tag_NUB6,tag_NUB7,tag_NUB8,Second_pro_bitplane1,Second_pro_bitplane2,Second_pro_bitplane3,Second_pro_bitplane4,Second_pro_bitplane5,Second_pro_bitplane6,Second_pro_bitplane7,Second_pro_bitplane8] = Preprocess2(compress_type_len,tag_preprocess,finalem,f,block_size,Process_bitplane1,Process_bitplane2,Process_bitplane3,Process_bitplane4,Process_bitplane5,Process_bitplane6,Process_bitplane7,Process_bitplane8)
%函数输入：compress_type_len(每个位平面type压缩后的位数),tag_preprocess（位平面可嵌标记）,finalem（位平面UB可嵌信息的坐标）,f（NUB的个数）,block_size,Process_bitplane1(重排自嵌入后的位平面)
%函数输出：final_emUBdata(在UB中嵌入信息的坐标),tag1(位平面里NUB是否可嵌信息的标记)，Second_pro_bitplane1（重排且自嵌type和NUB的位平面）
%函数描述：将压缩后的NUB序列，嵌入UB
tag_NUB1=0;tag_NUB2=0;tag_NUB3=0;tag_NUB4=0;
tag_NUB5=0;tag_NUB6=0;tag_NUB7=0;tag_NUB8=0; %预先定义一些tag_NUB,防止根据tag_process有的位平面不可以嵌入信息
bin_NUB1_len=0;bin_NUB2_len=0;bin_NUB3_len=0;bin_NUB4_len=0;
bin_NUB5_len=0;bin_NUB6_len=0;bin_NUB7_len=0;bin_NUB8_len=0;
em_UB_datax1=finalem(1,1);em_UB_datay1=finalem(1,2);em_UB_datax2=finalem(2,1);em_UB_datay2=finalem(2,2);em_UB_datax3=finalem(3,1);em_UB_datay3=finalem(3,2);em_UB_datax4=finalem(4,1);em_UB_datay4=finalem(4,2);
em_UB_datax5=finalem(5,1);em_UB_datay5=finalem(5,2);em_UB_datax6=finalem(6,1);em_UB_datay6=finalem(6,2);em_UB_datax7=finalem(7,1);em_UB_datay7=finalem(7,2);em_UB_datax8=finalem(8,1);em_UB_datay8=finalem(8,2);
if tag_preprocess(1)==1
   fnub1=f(1);
   [tag_NUB1] = NUBjudge(Process_bitplane1,block_size,fnub1); 
   flow_map1=tag_NUB1;
   bin_NUB1_len = length(flow_map1); %压缩后的NUB长度
   bin_NUB1 = flow_map1;
   cPos_x = cell(1,1);%算术编码压缩   %after compression
   cPos_x{1} = flow_map1;
   loc_Com =  arith07(cPos_x);
   bin_index = 8;
   [bin_NUB1,bin_NUB1_len] = dec_transform_bin(loc_Com, bin_index); 
   emNUB_x1=finalem(1,1);
   emNUB_y1=finalem(1,2); %将NUB序列的个数，和NUB判断序列，嵌入UB中。 
   compress_type_len1=compress_type_len(1);
   [Second_pro_bitplane1,em_UB_datax1,em_UB_datay1] = embed_NUB_inUB(compress_type_len1,block_size,Process_bitplane1,bin_NUB1,emNUB_x1,emNUB_y1,fnub1);
else
   Second_pro_bitplane1=Process_bitplane1;
end
if tag_preprocess(2)==1
   fnub2=f(2);
   [tag_NUB2] = NUBjudge(Process_bitplane2,block_size,fnub2); 
   flow_map2=tag_NUB2;
   bin_NUB2_len = length(flow_map2);
   bin_NUB2 = flow_map2;
   cPos_x = cell(1,1);%算术编码压缩
   cPos_x{1} = flow_map2;
   loc_Com =  arith07(cPos_x);
   bin_index = 8;
   [bin_NUB2,bin_NUB2_len] = dec_transform_bin(loc_Com, bin_index); 
   emNUB_x2=finalem(2,1);
   emNUB_y2=finalem(2,2); %将NUB序列的个数，和NUB判断序列，嵌入UB中。
   compress_type_len2=compress_type_len(2);
   [Second_pro_bitplane2,em_UB_datax2,em_UB_datay2] = embed_NUB_inUB(compress_type_len2,block_size,Process_bitplane2,bin_NUB2,emNUB_x2,emNUB_y2,fnub2);
else
   Second_pro_bitplane2=Process_bitplane2;
end
if tag_preprocess(3)==1
   fnub3=f(3);
   [tag_NUB3] = NUBjudge(Process_bitplane3,block_size,fnub3); 
   flow_map3=tag_NUB3;
   bin_NUB3_len = length(flow_map3);
   bin_NUB3 = flow_map3;
   cPos_x = cell(1,1);%算术编码压缩
   cPos_x{1} = flow_map3;
   loc_Com =  arith07(cPos_x);
   bin_index = 8;
   [bin_NUB3,bin_NUB3_len] = dec_transform_bin(loc_Com, bin_index); 
   emNUB_x3=finalem(3,1);
   emNUB_y3=finalem(3,2); %将NUB序列的个数，和NUB判断序列，嵌入UB中。
   compress_type_len3=compress_type_len(3);
   [Second_pro_bitplane3,em_UB_datax3,em_UB_datay3] = embed_NUB_inUB(compress_type_len3,block_size,Process_bitplane3,bin_NUB3,emNUB_x3,emNUB_y3,fnub3);   
else
   Second_pro_bitplane3=Process_bitplane3;
end
if tag_preprocess(4)==1
   fnub4=f(4);
   [tag_NUB4] = NUBjudge(Process_bitplane4,block_size,fnub4); 
   flow_map4=tag_NUB4;
   bin_NUB4_len = length(flow_map4);
   bin_NUB4 = flow_map4;
   cPos_x = cell(1,1);%算术编码压缩
   cPos_x{1} = flow_map4;
   loc_Com =  arith07(cPos_x);
   bin_index = 8;
   [bin_NUB4,bin_NUB4_len] = dec_transform_bin(loc_Com, bin_index);
   emNUB_x4=finalem(4,1);
   emNUB_y4=finalem(4,2); %将NUB序列的个数，和NUB判断序列，嵌入UB中。
   compress_type_len4=compress_type_len(4);
   [Second_pro_bitplane4,em_UB_datax4,em_UB_datay4] = embed_NUB_inUB(compress_type_len4,block_size,Process_bitplane4,bin_NUB4,emNUB_x4,emNUB_y4,fnub4);   
else
   Second_pro_bitplane4=Process_bitplane4;
end
if tag_preprocess(5)==1
   fnub5=f(5);
   [tag_NUB5] = NUBjudge(Process_bitplane5,block_size,fnub5);  
   flow_map5=tag_NUB5;
   bin_NUB5_len = length(flow_map5);
   bin_NUB5 = flow_map5;
   %after compression
   cPos_x = cell(1,1);%算术编码压缩
   cPos_x{1} = flow_map5;
   loc_Com =  arith07(cPos_x);
   bin_index = 8;
   [bin_NUB5,bin_NUB5_len] = dec_transform_bin(loc_Com, bin_index); 
   emNUB_x5=finalem(5,1);
   emNUB_y5=finalem(5,2); %将NUB序列的个数，和NUB判断序列，嵌入UB中。
   compress_type_len5=compress_type_len(5);
   [Second_pro_bitplane5,em_UB_datax5,em_UB_datay5] = embed_NUB_inUB(compress_type_len5,block_size,Process_bitplane5,bin_NUB5,emNUB_x5,emNUB_y5,fnub5);   
else
   Second_pro_bitplane5=Process_bitplane5;
end
if tag_preprocess(6)==1
   fnub6=f(6);
   [tag_NUB6] = NUBjudge(Process_bitplane6,block_size,fnub6); 
   flow_map6=tag_NUB6;
   bin_NUB6_len = length(flow_map6);
   bin_NUB6 = flow_map6;
   cPos_x = cell(1,1);%算术编码压缩
   cPos_x{1} = flow_map6;
   loc_Com =  arith07(cPos_x);
   bin_index = 8;
   [bin_NUB6,bin_NUB6_len] = dec_transform_bin(loc_Com, bin_index);
   emNUB_x6=finalem(6,1);
   emNUB_y6=finalem(6,2); %将NUB序列的个数，和NUB判断序列，嵌入UB中。
   compress_type_len6=compress_type_len(6);
   [Second_pro_bitplane6,em_UB_datax6,em_UB_datay6] = embed_NUB_inUB(compress_type_len6,block_size,Process_bitplane6,bin_NUB6,emNUB_x6,emNUB_y6,fnub6);   
else
   Second_pro_bitplane6=Process_bitplane6;
end
if tag_preprocess(7)==1
   fnub7=f(7);
   [tag_NUB7] = NUBjudge(Process_bitplane7,block_size,fnub7) ; 
   flow_map7=tag_NUB7;
   bin_NUB7_len = length(flow_map7);
   bin_NUB7 = flow_map7;
   cPos_x = cell(1,1);%算术编码压缩
   cPos_x{1} = flow_map7;
   loc_Com =  arith07(cPos_x);
   bin_index = 8;
   [bin_NUB7,bin_NUB7_len] = dec_transform_bin(loc_Com, bin_index); 
   emNUB_x7=finalem(7,1);
   emNUB_y7=finalem(7,2); %将NUB序列的个数，和NUB判断序列，嵌入UB中。
   compress_type_len7=compress_type_len(7);
   [Second_pro_bitplane7,em_UB_datax7,em_UB_datay7] = embed_NUB_inUB(compress_type_len7,block_size,Process_bitplane7,bin_NUB7,emNUB_x7,emNUB_y7,fnub7);
else
   Second_pro_bitplane7=Process_bitplane7;
end
if tag_preprocess(8)==1
   fnub8=f(8);
   [tag_NUB8] = NUBjudge(Process_bitplane8,block_size,fnub8);
   flow_map8=tag_NUB8;
   bin_NUB8_len = length(flow_map8);
   cPos_x = cell(1,1);%算术编码压缩
   cPos_x{1} = flow_map8;
   loc_Com =  arith07(cPos_x);
   bin_index = 8;
   [bin_NUB8,bin_NUB8_len] = dec_transform_bin(loc_Com, bin_index);
   emNUB_x8=finalem(8,1);
   emNUB_y8=finalem(8,2); %将NUB序列的个数，和NUB判断序列，嵌入UB中。
   compress_type_len8=compress_type_len(8);
   [Second_pro_bitplane8,em_UB_datax8,em_UB_datay8] = embed_NUB_inUB(compress_type_len8,block_size,Process_bitplane8,bin_NUB8,emNUB_x8,emNUB_y8,fnub8);   
else
   Second_pro_bitplane8=Process_bitplane8;
end
final_emUBdata=zeros(8,2); %在UB中嵌入信息的位置
final_emUBdata(1,1)=em_UB_datax1;final_emUBdata(1,2)=em_UB_datay1;final_emUBdata(2,1)=em_UB_datax2;final_emUBdata(2,2)=em_UB_datay2;final_emUBdata(3,1)=em_UB_datax3;final_emUBdata(3,2)=em_UB_datay3;final_emUBdata(4,1)=em_UB_datax4;final_emUBdata(4,2)=em_UB_datay4;
final_emUBdata(5,1)=em_UB_datax5;final_emUBdata(5,2)=em_UB_datay5;final_emUBdata(6,1)=em_UB_datax6;final_emUBdata(6,2)=em_UB_datay6;final_emUBdata(7,1)=em_UB_datax7;final_emUBdata(7,2)=em_UB_datay7;final_emUBdata(8,1)=em_UB_datax8;final_emUBdata(8,2)=em_UB_datay8;
bin_NUB_len=zeros(1,8);
bin_NUB_len(1)=bin_NUB1_len;bin_NUB_len(2)=bin_NUB2_len;bin_NUB_len(3)=bin_NUB3_len;bin_NUB_len(4)=bin_NUB4_len;
bin_NUB_len(5)=bin_NUB5_len;bin_NUB_len(6)=bin_NUB6_len;bin_NUB_len(7)=bin_NUB7_len;bin_NUB_len(8)=bin_NUB8_len;
end

function [Second_pro_bitplane1,em_UB_datax1,em_UB_datay1] = embed_NUB_inUB(compress_type_len1,block_size,Process_bitplane1,bin_NUB1,emNUB_x1,emNUB_y1,fnub1)
[row,col] = size(Process_bitplane1);
block_m = floor(row/block_size);  %分块大小为block_size*block_size
block_n = floor(col/block_size);  %分块个数为block_m*block_n，每行有block_m个分块

ftypeI_block = ceil(compress_type_len1/(block_size*block_size-1)); 

Second_pro_bitplane1=Process_bitplane1;
num_binNUB1 = length(bin_NUB1);%当前位平面NUB的块数
binNUB1_block=ceil(num_binNUB1/(block_size*block_size-1)); %压缩后的NUB 所占UB的块数

startx_emdata = emNUB_x1; %UB中嵌入NUB的开始坐标
starty_emdata = emNUB_y1;
start_d2=0;

% if mod((startx_emdata-1),block_size)==0 && mod((starty_emdata-1),block_size)==0 %如果是从没有嵌入typeI的UB块中开始嵌入
for i=1:num_binNUB1 %一共嵌入的位数：是压缩后的NUB元素数
   for p=0:block_size-1
       for q=0:block_size-1
           if (p==block_size-1 && q==block_size-1) || start_d2>=num_binNUB1                                                                                                                                                   
               break;
           else
               start_d2 = start_d2+1;
               vx = startx_emdata + p;
               vy = starty_emdata + q;
               Second_pro_bitplane1(vx,vy) = bin_NUB1(start_d2);
               if start_d2==num_binNUB1
                   last_block=mod((fnub1+ftypeI_block+binNUB1_block),block_n); %当前这一行，有几个4*4的块
                   em_UB_datay1=last_block*block_size+1;
                   em_UB_datax1=(floor((fnub1+ftypeI_block+binNUB1_block)/block_n))*block_size+1;
               end
           end
       end
   end
   if start_d2>=num_binNUB1
      break;
   end         
   if vy==block_n*block_size-1 && mod(vx,block_size)==0 && vx~=block_m*block_size 
       startx_emdata = vx + 1; %换到下一行
       starty_emdata = 1;
   else
       starty_emdata = vy + 2;
   end
end
end

