function [typeI1,typeI2,typeI3,typeI4,typeI5,typeI6,typeI7,typeI8,compress_type_len,recover_start_ub,Predict_error_I,judge_predict,compress_predict,tag_preprocess,finalem,f,Process_bitplane1,Process_bitplane2,Process_bitplane3,Process_bitplane4,Process_bitplane5,Process_bitplane6,Process_bitplane7,Process_bitplane8] = Preprocess1(Origin_I,block_size)
% 函数说明：生成预测误差图像，将其分为八个位平面，并重排列
% 输入：Origin_I（原始图像）， block_size（分块大小）
% 输出：compress_type_len(每个位平面type压缩后的位数),recover_start_ub（UB开始坐标），Predict_error_I(预测误差图像),judge_predict(是否为越界预测误差),tag_preprocess(记录每个位平面是否重排列),finalem(在UB中继续嵌入NUB压缩数据的位置)，f（一维数组，位平面中NUB的数量）
%% 产生预测误差图像
[Predict_error_I,judge_predict,compress_predict] = Predict_error(Origin_I);
%% 产生预测误差位平面
[PE_bitplane1,PE_bitplane2,PE_bitplane3,PE_bitplane4,PE_bitplane5,PE_bitplane6,PE_bitplane7,PE_bitplane8] = One_to_eight(Predict_error_I,judge_predict);
%% 产生8个重排位平面
[compress_type_len1,typeI1,Process_bitplane1,tag1,f1,recover_start_ubx1,recover_start_uby1,finalem_x1,finalem_y1] = Rearrange(PE_bitplane1,block_size);
[compress_type_len2,typeI2,Process_bitplane2,tag2,f2,recover_start_ubx2,recover_start_uby2,finalem_x2,finalem_y2] = Rearrange(PE_bitplane2,block_size);
[compress_type_len3,typeI3,Process_bitplane3,tag3,f3,recover_start_ubx3,recover_start_uby3,finalem_x3,finalem_y3] = Rearrange(PE_bitplane3,block_size);
[compress_type_len4,typeI4,Process_bitplane4,tag4,f4,recover_start_ubx4,recover_start_uby4,finalem_x4,finalem_y4] = Rearrange(PE_bitplane4,block_size);
[compress_type_len5,typeI5,Process_bitplane5,tag5,f5,recover_start_ubx5,recover_start_uby5,finalem_x5,finalem_y5] = Rearrange(PE_bitplane5,block_size);
[compress_type_len6,typeI6,Process_bitplane6,tag6,f6,recover_start_ubx6,recover_start_uby6,finalem_x6,finalem_y6] = Rearrange(PE_bitplane6,block_size);
[compress_type_len7,typeI7,Process_bitplane7,tag7,f7,recover_start_ubx7,recover_start_uby7,finalem_x7,finalem_y7] = Rearrange(PE_bitplane7,block_size);
[compress_type_len8,typeI8,Process_bitplane8,tag8,f8,recover_start_ubx8,recover_start_uby8,finalem_x8,finalem_y8] = Rearrange(PE_bitplane8,block_size);
%% 整合数据
tag_preprocess=zeros(1,8); %每个位平面是否可嵌入的标记
tag_preprocess(1:8)=[tag1 tag2 tag3 tag4 tag5 tag6 tag7 tag8];
finalem=zeros(8,2); %在UB中嵌入NUB的起始坐标
finalem(1,1)=finalem_x1;finalem(1,2)=finalem_y1;finalem(2,1)=finalem_x2;finalem(2,2)=finalem_y2;finalem(3,1)=finalem_x3;finalem(3,2)=finalem_y3;finalem(4,1)=finalem_x4;finalem(4,2)=finalem_y4;
finalem(5,1)=finalem_x5;finalem(5,2)=finalem_y5;finalem(6,1)=finalem_x6;finalem(6,2)=finalem_y6;finalem(7,1)=finalem_x7;finalem(7,2)=finalem_y7;finalem(8,1)=finalem_x8;finalem(8,2)=finalem_y8;
f=zeros(1,8);
f(1:8)=[f1 f2 f3 f4 f5 f6 f7 f8];
recover_start_ub=zeros(8,2); %恢复UB的起始坐标
recover_start_ub(1,1)=recover_start_ubx1;recover_start_ub(1,2)=recover_start_uby1;recover_start_ub(2,1)=recover_start_ubx2;recover_start_ub(2,2)=recover_start_uby2;
recover_start_ub(3,1)=recover_start_ubx3;recover_start_ub(3,2)=recover_start_uby3;recover_start_ub(4,1)=recover_start_ubx4;recover_start_ub(4,2)=recover_start_uby4;
recover_start_ub(5,1)=recover_start_ubx5;recover_start_ub(5,2)=recover_start_uby5;recover_start_ub(6,1)=recover_start_ubx6;recover_start_ub(6,2)=recover_start_uby6;
recover_start_ub(7,1)=recover_start_ubx7;recover_start_ub(7,2)=recover_start_uby7;recover_start_ub(8,1)=recover_start_ubx8;recover_start_ub(8,2)=recover_start_uby8;
compress_type_len=zeros(1,8);%每个位平面，typeimage压缩后的位数
compress_type_len(1)=compress_type_len1;compress_type_len(2)=compress_type_len2;compress_type_len(3)=compress_type_len3;compress_type_len(4)=compress_type_len4;
compress_type_len(5)=compress_type_len5;compress_type_len(6)=compress_type_len6;compress_type_len(7)=compress_type_len7;compress_type_len(8)=compress_type_len8;
end

function [Predict_error_I,judge_predict,compress_predict] = Predict_error(Origin_I) 
[row,col] = size(Origin_I); %计算origin_I的行列值
Predict_error_I = Origin_I;  %构建存储origin_I预测值的容器
judge_predict = ones(row,col)*Inf;
for i=2:row  %第一行是参考像素，不用预测
    for j=2:col  %第一列作为参考像素，不用预测
        a = Origin_I(i-1,j);
        b = Origin_I(i-1,j-1);
        c = Origin_I(i,j-1);
        if b <= min(a,c)
            Predict_error_I(i,j) = Origin_I(i,j)-max(a,c);
            
        elseif b >= max(a,c)
            Predict_error_I(i,j) = Origin_I(i,j)-min(a,c);
        else
            Predict_error_I(i,j) = Origin_I(i,j)-(a + c - b);
        end
    end
end %产生预测误差图像
%------------判断除了参考像素外，存在的越界预测误差像素（大于64和小于-64）-----------%
i=1;
for j=1:col
   judge_predict(i,j)=0; %所有参考像素的判断都是0，即正确可恢复像素  
end
j=1;
for i=2:row
   judge_predict(i,j)=0;
end
for i=2:row
    for j=2:col
        if (Predict_error_I(i,j)>64 ) || (Predict_error_I(i,j)<-64)
            Predict_error_I(i,j) = Origin_I(i,j); %越界像素不计算预测误差
            judge_predict(i,j)=1;
        else
            judge_predict(i,j)=0;
        end
    end
end
%------------- 压缩判断预测误差的矩阵，方便后续嵌入 -----------%
flow_map=judge_predict;

compress_predict_len = length(flow_map);
compress_predict = flow_map;
%after compression
cPos_x = cell(1,1);%算术编码压缩
cPos_x{1} = flow_map;
loc_Com =  arith07(cPos_x);
bin_index = 8;
[compress_predict, compress_predict_len] = dec_transform_bin(loc_Com, bin_index);

end 
function [PE_bitplane1,PE_bitplane2,PE_bitplane3,PE_bitplane4,PE_bitplane5,PE_bitplane6,PE_bitplane7,PE_bitplane8] = One_to_eight(Predict_error_I,judge_predict)
 [row,col] = size(Predict_error_I); 
 PE_bitplane1 = zeros(row,col);PE_bitplane2 = zeros(row,col);PE_bitplane3 = zeros(row,col);PE_bitplane4 = zeros(row,col);
 PE_bitplane5 = zeros(row,col);PE_bitplane6 = zeros(row,col);PE_bitplane7 = zeros(row,col);PE_bitplane8 = zeros(row,col);
 bin2 = zeros(1,8);
 i=1;
 for j=1:col
    bin2 = Decimalism_Binary(Predict_error_I(i,j)); %参考像素采用常规的十进制化八位二进制的方法
    PE_bitplane1(i,j)= bin2(1);PE_bitplane2(i,j)= bin2(2);PE_bitplane3(i,j)= bin2(3);PE_bitplane4(i,j)= bin2(4);
    PE_bitplane5(i,j)= bin2(5);PE_bitplane6(i,j)= bin2(6);PE_bitplane7(i,j)= bin2(7);PE_bitplane8(i,j)= bin2(8);       
 end
 j=1;
 for i=2:row
    bin2 = Decimalism_Binary(Predict_error_I(i,j)); %参考像素采用常规的十进制化八位二进制的方法
    PE_bitplane1(i,j)= bin2(1);PE_bitplane2(i,j)= bin2(2);PE_bitplane3(i,j)= bin2(3);PE_bitplane4(i,j)= bin2(4);
    PE_bitplane5(i,j)= bin2(5);PE_bitplane6(i,j)= bin2(6);PE_bitplane7(i,j)= bin2(7);PE_bitplane8(i,j)= bin2(8);      
 end
 for i=2:row
    for j=2:col
        if judge_predict(i,j)==0 %标记为0，当前像素可以计算预测差值的，则计算
           bin2 = zf_Decimalism_Binary(Predict_error_I(i,j)); %bin2数组的第一个，是最高位平面
           PE_bitplane1(i,j)= bin2(1);PE_bitplane2(i,j)= bin2(2);PE_bitplane3(i,j)= bin2(3);PE_bitplane4(i,j)= bin2(4);
           PE_bitplane5(i,j)= bin2(5);PE_bitplane6(i,j)= bin2(6);PE_bitplane7(i,j)= bin2(7);PE_bitplane8(i,j)= bin2(8); 
        else
           bin2 = Decimalism_Binary(Predict_error_I(i,j)); %越界像素无法用7位表示，要用8位
           PE_bitplane1(i,j)= bin2(1);PE_bitplane2(i,j)= bin2(2);PE_bitplane3(i,j)= bin2(3);PE_bitplane4(i,j)= bin2(4);
           PE_bitplane5(i,j)= bin2(5);PE_bitplane6(i,j)= bin2(6);PE_bitplane7(i,j)= bin2(7);PE_bitplane8(i,j)= bin2(8); 
        end
    end
 end
end %产生八个位平面
function [compress_type_len,typeI,Process_bitplane1,tag,f,recover_start_ubx,recover_start_uby,finalem_x1,finalem_y1] = Rearrange(PE_bitplane1,block_size)
%输出说明：f（NUB的块数）
[row,col] = size(PE_bitplane1); %统计图像的行列数
block_m = floor(row/block_size);  %分块大小为block_size*block_size
block_n = floor(col/block_size);  %分块个数为block_m*block_n，每行有block_m个分块
typeI = ones(block_m,block_n)*Inf;  %创造type image 128*128矩阵
Process_bitplane1 = PE_bitplane1;
tag =0;%记录当前位平面有没有重排列的标记
%% 构建typeimage
for i=1:block_m
    for j=1:block_n
        start_x = (i-1)*block_size + 1; %求每个分块的起始坐标
        start_y = (j-1)*block_size + 1;
        flag = PE_bitplane1(start_x,start_y);
        for t = 0:block_size-1  %检查每个块内是否是均匀块，若是NUB，则typeimage为0，否则为1
            for k = 0:block_size-1
                if PE_bitplane1(start_x+t,start_y+k) == flag
                    typeI(i,j) = 0; %UB块是0，NUB是1
                else
                    typeI(i,j) = 1; %只要块内有一个不同，则break
                    break;
                end
            end
            if typeI(i,j) == 1   
                break;
            end
        end
    end
end
f = 0; %求出图像中NUBs的块数f
for i=1:block_m
    for j=1:block_n
        if typeI(i,j) == 1
            f = f + 1;
        end
    end
end
%% 压缩typeimage
flow_map=typeI;

compress_type_len = length(flow_map);
compress_type = flow_map;
%after compression
cPos_x = cell(1,1);%算术编码压缩
cPos_x{1} = flow_map;
loc_Com =  arith07(cPos_x);
bin_index = 8;
[compress_type,compress_type_len] = dec_transform_bin(loc_Com, bin_index);
%--------------------------------------------------------------------------------------
ftypeI = compress_type_len; %typeI比特流的总数目
start_nubx = 1; %重排图像中每个NUBs分块的起始坐标
start_nuby = 1;
start_ubx = floor(f/block_n)*block_size+1; %重排图像中UBs的开始坐标
start_uby = (mod(f,block_n))*block_size + 1;
recover_start_ubx = start_ubx; %留存，恢复图像时要用
recover_start_uby = start_uby;
%% 重新排列
% if (block_m*block_n-f)*(block_size*block_size-1)<= ftypeI  %UB装不下typeimage和数量，则不重排列
%     tag=0;
%     recover_start_ubx=0;
%     recover_start_uby=0; %该位平面没有重排列，所以不存在先恢复UB
% else
%     tag=1;
% end
% if tag==1
 for i=1:block_m
    for j=1:block_n
        start_x = (i-1)*block_size + 1; %原始图像逐个扫描，每个分块的起始坐标
        start_y = (j-1)*block_size + 1;
        if typeI(i,j) == 1       %type image是1，即 NUBs （改过）
            for x=0:block_size-1  %逐个从每个分块的起始坐标起算重排图像中NUBs的坐标,并将NUBs放到重排图像的上方
                for y=0:block_size-1
                    vx = start_x + x; %原始图像点的坐标
                    vy = start_y + y;
                    nubx = start_nubx + x; %求重排图像中每个NUB分块中，各个像素点的坐标
                    nuby = start_nuby + y;
                    Process_bitplane1(nubx,nuby) = PE_bitplane1(vx,vy);
                end
            end
%             if nuby == col
            if nuby == block_n*block_size %若嵌入的NUB达到每排最后一个，则坐标换到下一排
                start_nubx = nubx + 1;
                start_nuby = 1;
            else
                start_nuby = nuby + 1;
            end
        else
            for x=0:block_size-1    %UB从26行，第85个块，即337列
                for y=0:block_size-1
                    vx = start_x + x; %原始图像点的坐标
                    vy = start_y + y;
                    ubx = start_ubx + x; %求重排图像中每个分块各个点的坐标
                    uby = start_uby + y;
                    Process_bitplane1(ubx,uby) = PE_bitplane1(vx,vy); %将UBs放到重排图像的下面
                end
            end
%             if uby == col 
            if uby == block_n*block_size %若嵌入的UB达到每排最后一个，则坐标换到下一排
                start_ubx = ubx + 1;
                start_uby = 1;
            else
                start_uby = uby + 1;
            end
        end
    end
 end
% end
%% 压缩NUB,判断当前位平面能否重排列并嵌入信息
[tag_NUB] = NUBjudge(Process_bitplane1,block_size,f);
flow_map=tag_NUB;
compress_NUB_len = length(flow_map);
compress_NUB = flow_map;
%after compression
cPos_x = cell(1,1);%算术编码压缩
cPos_x{1} = flow_map;
loc_Com =  arith07(cPos_x);
bin_index = 8;
[compress_NUB, compress_NUB_len] = dec_transform_bin(loc_Com, bin_index);
%----------------------------------------------------------------------------
if (block_m*block_n-f)*(block_size*block_size-1)<= (ftypeI+compress_NUB_len+15)  %UB装不下压缩后的typeimage和压缩后的NUB数量，则不重排列
    tag=0;
    recover_start_ubx=0;
    recover_start_uby=0; %该位平面没有重排列，所以不存在先恢复UB
    Process_bitplane1=PE_bitplane1; %取消上面重排列的步骤
    compress_type_len=0; 
else
    tag=1;
end
%% 将typeI矩阵转换为一维数组，嵌入到UBs中(要记录typeI嵌入的结束位置)
if tag==1
 EMtypeI = compress_type; %将要嵌入的type image
 start_EMubx = recover_start_ubx; %重排图像中UBs的开始坐标
 start_EMuby = recover_start_uby;
 g = 0; %EMtypeI嵌入的个数
 for i=1:block_m
    for j=1:block_n
        if (i-1)*block_n+j>f %遍历的是UB块，而不是NUB
            for x=0:block_size-1       %逐个从每个分块的起始坐标起算预测误差
                for y=0:block_size-1
                    if g >= ftypeI %typeI序列已经全部嵌完，右下不嵌入
                        break;  
                    end
                    if x~=block_size-1 || y~=block_size-1 %右下的一个点是预测像素，跳过
                        g = g + 1;
                        vx = start_EMubx + x; %所求点的坐标
                        vy = start_EMuby + y;
                        Process_bitplane1(vx,vy) = EMtypeI(g);
                        
                    end
                end
                if g >= ftypeI %typeI序列已经全部嵌完，右下不嵌入
                    break;  
                end
            end
            if vy+1 == block_n*block_size
                start_EMubx = vx + 1;
                start_EMuby = 1;
            else
                start_EMuby = vy + 2;
            end
        end
        if g >= ftypeI %若嵌入的type image 序列数量大于UBs中可嵌入空间
            break;
        end
    end
    if g >= ftypeI %若嵌入的type image 序列数量大于typaimage个数，跳出
        break;
    end
 end
end
%% 计算typeI最后一位的嵌入位置,并 返回在UB中嵌入秘密数据的 开始坐标（最后一个嵌入typeimage的块，剩余像素暂时不要）
finalem_x1 = 0;
finalem_y1 = 0;
ftypeI_block = ceil(ftypeI/(block_size*block_size-1));%压缩后的typeiage占用的4*4块数(1093块)
if tag==1 
    last_block=mod((f+ftypeI_block),block_n); %当前这一行，有几个4*4的块
    finalem_y1=last_block*block_size+1;
    finalem_x1=(floor((f+ftypeI_block)/block_n))*block_size+1;
end
end %重排列