function[corrected_data] = find_error2(new_data_path)
%USAGE: 'new_data_path' is the path of filled data for read & write
%       'corrected_data' is the corrected_data
% Author: Zeyu
% 2019-09-20 10:26:32 @ SUT
%% ====main_function====
    [~,~,raw] = xlsread(new_data_path);
    speed_sequence = raw([2:end],2);
    for i = 1:length(speed_sequence)-1
        acceleration_sequence(i) = speed_sequence{i+1}/3.6 -  speed_sequence{i}/3.6;        
    end
    idx = find(acceleration_sequence<-8 | acceleration_sequence>3.97);
    for i = 1:length(idx)
        speed_sequence{idx(i)+1} = (speed_sequence{idx(i)+2} + speed_sequence{idx(i)})*0.5;
    end
    raw([2:end],2) = speed_sequence;
    corrected_data = raw;
    xlswrite(new_data_path, raw , 'Sheet1')
    
end