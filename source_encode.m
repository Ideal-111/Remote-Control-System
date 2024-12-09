function [out,len_encode] = source_encode(x,dict,N)
    out = huffmanenco(x,dict);
    len_encode = length(out);
    len = length(x);
    len_before_encode = len*N;
    fprintf('-------- source_encode --------\n');
    fprintf('信源编码前字符串总长度 : %d\n', len_before_encode);
    fprintf('信源编码后字符串二进制总长度 : %d\n', len_encode);
    fprintf('压缩率 : %f\n', len_before_encode/len_encode);
end