function [demodulation_out] = demodulation(x)
    out = pskdemod(x,4);
    for i = 1:length(out)
        m = dec2bin(out(i), 2);
        x = str2double(m(1));
        y = str2double(m(2));
        out1(2*i-1) = x;
        out1(2*i) = y;
    end
    demodulation_out = out1';
end