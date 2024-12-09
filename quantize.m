function [out, q] = quantize(cmd, fs, N)
    q = (1-(-1))/2^N;
    out = floor((cmd+1)/q);

    % 量化和原始信号对比
    len = length(cmd);
    ts = (0:len-1)/fs;
    figure;
    subplot(2,1,1);
    plot(ts, cmd, 'b');
    title('原始语音信号');
    restore = q*out-1;
    subplot(2,1,2);
    plot(ts, restore, 'r');
    title('量化后原始语音信号');
    ylim([-1 1]);
    xlabel('Time(s)');ylabel('Amplitude');
end