function [Process_I] = eight_to_one(Process_bitplane1,Process_bitplane2,Process_bitplane3,Process_bitplane4,Process_bitplane5,Process_bitplane6,Process_bitplane7,Process_bitplane8)
% 函数说明：将八个位平面转为一个图
[row,col] = size(Process_bitplane1);
Process_I = ones(row,col)*Inf;
bin2=zeros(1,8);
for i=1:row
  for j=1:col
        bin2(1)=Process_bitplane1(i,j);
        bin2(2)=Process_bitplane2(i,j);
        bin2(3)=Process_bitplane3(i,j);
        bin2(4)=Process_bitplane4(i,j);
        bin2(5)=Process_bitplane5(i,j);
        bin2(6)=Process_bitplane6(i,j);
        bin2(7)=Process_bitplane7(i,j);
        bin2(8)=Process_bitplane8(i,j);
        [value] = Binary_Decimalism(bin2);
        Process_I(i,j)=value;
  end
end

end

