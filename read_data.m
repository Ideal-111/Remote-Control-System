function[total_data] = read_data()
    yes_data = audioread('../cmd_data/yes.flac');
    up_data = audioread('../cmd_data/up.flac');
    stop_data = audioread('../cmd_data/stop.flac');
    right_data = audioread('../cmd_data/right.flac');
    on_data = audioread('../cmd_data/on.flac');
    off_data = audioread('../cmd_data/off.flac');
    no_data = audioread('../cmd_data/no.flac');
    left_data = audioread('../cmd_data/left.flac');
    go_data = audioread('../cmd_data/go.flac');
    down_data = audioread('../cmd_data/down.flac');
    total_data = [yes_data;up_data;stop_data;right_data;on_data;off_data;no_data;left_data;go_data;down_data];
end