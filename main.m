clc;
clear;
%% 参数设置
Fs = 8000;  %采样频率
snr = 10;    %信噪比
N = 8;      %量化位数
%% 生成码书
[dict, avglen] = create_dict;
%% 指令输入
cmd_in = Speak_input;
% cmd_in = audioread('../cmd_data/right.flac');
%% 量化
[out_q, ~] = quantize(cmd_in, Fs, N);
%% 信源编码
[out_enc,len_encode] = source_encode(out_q, dict, N);
%% 信道编码
[channel_enc, ~, trellis] = channel_encode(out_enc);
%% 调制+信道传输
% for snr = -20:20
modulation_out = modulation(channel_enc, snr);
% 接收端解调
demodulation_out = demodulation(modulation_out);
% 计算误码率
[err, ber] = biterr(demodulation_out, channel_enc);
% berr(snr+21) = ber;
% end
% figure;
% SNR = linspace(-20, 20, 41);
% plot(SNR, berr,'b*');
% axis([-20 20 0 0.5]);
% xlabel('SNR(dB)');ylabel('调制解调误比特率');
% title('不同SNR情况下的调制解调误比特率');
fprintf('-------- 调制&解调 --------\n');
fprintf('调制解调错误比特数 : %d\n', err);
fprintf('调制解调误比特率 : %f\n', ber);
%% 信道译码
[channel_dec, channel_len] = channel_decode(demodulation_out, trellis);
[err1, ber1] = biterr(out_enc, channel_dec);
fprintf('-------- channel_decode --------\n');
fprintf('调制解调错误比特数 : %d\n', err1);
fprintf('调制解调误比特率 : %f\n', ber1);
%% 信源译码
source_dec = huffmandeco(channel_dec, dict);
[err2, ber2] = biterr(source_dec, out_q);
fprintf('-------- source_decode --------\n');
fprintf('调制解调错误比特数 : %d\n', err2);
fprintf('调制解调误比特率 : %f\n', ber2);
%% 音频信号重建
 cmd_back = source_dec*(1/2^7) - 1;
%% 写入音频文件
audiowrite('../cmd_data/cmd_back.flac', cmd_back, Fs);
%% 深度学习语音识别后输出指令
Command = recognize_cmd('../cmd_data/cmd_back.flac');
disp('The command is:');
disp(Command);
%% plot
len = length(cmd_in);
ts = (0:len-1)/Fs;
% 时域图
figure(1);
subplot(211);
plot(ts, cmd_in, 'b');
title('原始语音信号');xlabel('time(s)');ylabel('Amplitude');
subplot(212);
plot(ts, cmd_back, 'r');
title('重建后的语音信号');xlabel('time(s)');ylabel('Amplitude');
%频域图
figure(2);
fft_cmd = fft(cmd_in, Fs);
f = 0:Fs/2-1;
subplot(211);
plot(f, abs(fft_cmd(1:Fs/2)), 'b');
title('原始语音信号频谱');
xlabel('frequency(Hz)');ylabel('Amplitude');
fft_r = fft(cmd_back, Fs);
subplot(212);
plot(f, abs(fft_r(1:Fs/2)), 'r');
title('重建语音信号频谱');
xlabel('frequency(Hz)');ylabel('Amplitude');




