function [dict, avglen] = create_dict() %生成码书
    N = 8;
    q = (1-(-1))/2^N;
    data = read_data;

    x = floor((data+1)/q);
    len = length(x);
    % 分组
    unique_x = unique(x);
    unique_len = length(unique_x);
    symbols = cell(1, unique_len);
    freq = zeros(1, unique_len);

    %计算概率
    for i = 1:unique_len
        symbols{1,i} = unique_x(i);
        freq(i) = numel(find(x==unique_x(i))) / len;
    end

    % 根据符号集symbols和概率数组p计算Huffman编码词典
    [dict, avglen] = huffmandict(symbols, freq);

    fprintf('平均码长 : %f\n', avglen);
    fprintf('信源熵 : %f\n', sum(freq.*(-log2(freq))));
    fprintf('编码效率 : %f\n', sum(freq.*(-log2(freq)))/avglen);
end
