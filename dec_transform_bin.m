function [bin_matrix, len] = dec_transform_bin(dec_matrix, bin_index);
nSize = length(dec_matrix);
mDec_num = max(dec_matrix);
len = bin_index * nSize;
bin_matrix = zeros(1, len);
for i=1 : nSize
    bpoint = dec2bin(dec_matrix(i));
    nbitSize = length(bpoint);
    cpoint = zeros(1, nbitSize);
    apoint = zeros(1, bin_index);
    for j = 1 : nbitSize
       cpoint(j) = bin2dec(bpoint(j));
    end
    if ((nbitSize < bin_index) & (nbitSize >= 1))
        nleft_shift = bin_index - nbitSize;
        apoint((nleft_shift + 1) : bin_index) = cpoint;
        bin_matrix(((i - 1) * bin_index + 1) : bin_index * i) = apoint;
    elseif (nbitSize == bin_index)
        bin_matrix(((i - 1) * bin_index + 1) : bin_index * i) = cpoint;
    end
end
