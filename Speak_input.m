function [speak_in] = Speak_input()
    inst_speak = audiorecorder;
    disp('Start speaking');
    recordblocking(inst_speak,1);
    disp('End of Recording.');
    speak_in = getaudiodata(inst_speak);
    % 绘制录音数据波形
    plot(speak_in);
    play(inst_speak);
end