function [Process_bitplane1,tag,f,recover_start_ubx,recover_start_uby,finalem_x1,finalem_y1] = rerrange(PE_bitplane1,block_size)
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
                    typeI(i,j) = 1;
                else
                    typeI(i,j) = 0; %只要块内有一个不同，则break
                    break;
                end
            end
            if typeI(i,j) == 0   %0是NUB
                break;
            end
        end
    end
end
f = 0; %求出图像中NUBs的块数f
for i=1:block_m
    for j=1:block_n
        if typeI(i,j) == 0
            f = f + 1;
        end
    end
end
ftypeI = block_m*block_n; %typeI比特流的总数目
start_nubx = 1; %重排图像中每个NUBs分块的起始坐标
start_nuby = 1;
% start_ubx = floor(f/block_m)*4+1; %重排图像中UBs的开始坐标
% start_uby = (f - block_m*(start_ubx-1)/block_size)*block_size + 1;
 start_ubx = floor(f/block_n)*block_size+1; %重排图像中UBs的开始坐标(错了！！)
 start_uby = (mod(f,block_n))*block_size + 1;
recover_start_ubx = start_ubx; %留存，恢复图像时要用
recover_start_uby = start_uby;
%% 重新排列
if (block_m*block_n-f)*(block_size*block_size-1)<=ftypeI %UB装不下typeimage，则不重排列
    tag=0;
else
    tag=1;
end
if tag==1
 for i=1:block_m
    for j=1:block_n
        start_x = (i-1)*block_size + 1; %原始图像逐个扫描，每个分块的起始坐标
        start_y = (j-1)*block_size + 1;
        if typeI(i,j) == 0       %type image是0，即 NUBs
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
end
%% 将typeI矩阵转换为一维数组，嵌入到UBs中(要记录typeI嵌入的结束位置)
if tag==1
 EMtypeI = reshape(typeI.',1,block_m*block_n); %将要嵌入的type image
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
            end
%             if vy+1==col
            if vy+1 == block_n*block_size
                start_EMubx = vx + 1;
                start_EMuby = 1;
            else
                start_EMuby = vy + 2;
            end
        else
            break;
        end
        if g >= ftypeI %若嵌入的type image 序列数量大于UBs中可嵌入空间
            break;
        end
    end
 end
end
%% 计算typeI最后一位的嵌入位置,并 返回在UB中嵌入秘密数据的 开始坐标
finalem_x1 = 0;
finalem_y1 = 0;
ftypeI_block = ceil(block_m*block_n/(block_size*block_size-1));%typeiage占用的4*4块数(1093块)
if tag==1 
    if mod(block_m*block_n,(block_size*block_size-1))==0 %如果typeimage占用的块数正好是整数（即每一个块都嵌满）
        if mod((f + ftypeI_block),block_n)==0 %NUB块数加上Type占用块数，正好是某一行 块数的最后一个,则下一行第一个坐标嵌入信息
            finalem_x1 = ( (f + ftypeI_block)/block_n ) *block_size +1 ;
            finalem_y1 = 1;
        else %反之，在type后面一个块的第一个坐标，嵌入信息
            finalem_x1 = floor((f + ftypeI_block)/block_n)*block_size+1;
            finalem_y1 = mod((f + ftypeI_block),block_n)*block_size+1;
        end
    else %typeimage占用的块数非整数
       finalblock_typeInum = mod(block_m*block_n,(block_size*block_size-1)); %嵌入typeimage最后一个块的信息嵌入数
       if mod(finalblock_typeInum,block_size)==0 %最后一个块的信息嵌入数是4的倍数
           finalem_y1= mod(f+ftypeI_block-1,block_n)*block_size + 1;
           finalem_x1= floor((f+ftypeI_block-1)/block_n)*block_size + (finalblock_typeInum/block_size);
       else %最后一个块嵌入type的信息数，非4倍数
           finalem_y1= mod(f+ftypeI_block-1,block_n)*block_size + mod(finalblock_typeInum,block_size); 
           finalem_x1= floor((f+ftypeI_block-1)/block_n)*block_size + floor(finalblock_typeInum/block_size);
       end
    end
end
end %重排列

