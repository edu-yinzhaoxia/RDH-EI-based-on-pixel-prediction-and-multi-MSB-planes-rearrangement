function [value] = zf_Binary_Decimalism(bin2_8)
% % 函数说明：将二进制数组转换成十进制整数
% % 输出：bin2_8（二进制数组）
% % 输入：value（十进制整数）
value = 0;
len = length(bin2_8);
num_len=len-1;
if bin2_8(8)==0   %0代表正式
    for i=1:num_len
        value= value + bin2_8(i)*(2^(num_len-i));
    end
else
    for i=1:num_len
        value= value + bin2_8(i)*(2^(num_len-i));
    end
    value=-value;   
end

% for i=1:num_len
%     value = value + bin2_8(i)*(2^(num_len-i));
% end
% if bin2_8(len)==1
%      value = -value;
% end

end