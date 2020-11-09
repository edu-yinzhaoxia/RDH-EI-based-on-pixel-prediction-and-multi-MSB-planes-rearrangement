function [bin2_8] = zf_Decimalism_Binary(value)
% 函数说明：将十进制预测值转换成8位二进制数组（补码）,
% 输入：value（十进制预测值）
% 输出：bin2_8（8位二进制数组）
% 具体操作：最低位是符号位，其余七位是数值位（七位最大127）；负数符号位为1，正数符号位为0
if value>0
   bin2_8 = dec2bin(value)-'0';
   if length(bin2_8) < 8
      len = length(bin2_8);
      B = bin2_8;
      bin2_8 = zeros(1,8); %正数符号位为0
      for i=1:len
        bin2_8(7-len+i) = B(i); %不足8位前面补充0
      end 
   end
else
   value = -value;
   bin2_8 = dec2bin(value)-'0';
   if length(bin2_8) < 8
      len = length(bin2_8);
      B = bin2_8;
      bin2_8 = zeros(1,8);
      bin2_8(8)=1;           %负数符号位为1
      for i=1:len
        bin2_8(7-len+i) = B(i); %不足8位前面补充0
      end 
   end    
end

end
