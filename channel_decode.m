function [code, len] = channel_decode(QPSK_data, trellis)
    % 回溯深度 tblen = 5*(L-1) = 30
    code = vitdec(QPSK_data, trellis, 30, 'trunc', 'hard');
    len = length(code);
end