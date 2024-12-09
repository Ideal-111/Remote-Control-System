function [modulation_out] = modulation(x, snr)
    x1 = [];
    len = length(x);
    for i = 1:len/2
            x1(i) = string(x(2*i-1))+string(x(2*i));
            x2(i) = bin2dec(string(x1(i)));
    end
%QPSK 调制和 AWGN
    qpsk_out = pskmod(x2,4);
    modulation_out = awgn(qpsk_out, snr);
% % Scatterplot
    h = scatterplot(modulation_out);
    hold on
    scatterplot(qpsk_out,[],[],'r*',h);
end