function [Command] = recognize_cmd(filename)
    load('../cmd_data/Command.mat');
    [x,fs] = audioread(filename);
    auditorySpect = helperExtractAuditoryFeatures(x, fs);
    Command = classify(trainedNet, auditorySpect);
end