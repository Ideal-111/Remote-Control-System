function [code, len, trellis] = channel_encode(x)
    trellis = poly2trellis(7, [171 133]);
    code = convenc(x, trellis);
    len = length(code);
    fprintf('-------- channel_encode --------\n');
    fprintf('信道编码前字符串总长度 : %d\n', length(x));
    fprintf('信道编码后字符串二进制总长度 : %d\n', len);
    fprintf('编码速率：%.2f\n',length(x)/len);
end