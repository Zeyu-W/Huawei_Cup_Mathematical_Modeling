function[gap_idx,empty_position] = find_gap(data_path)
%USAGE: 'data_path' is the path of raw data 
%       'gap_idx' return the idx of time gap position
%       'empty_position' is the num of gap point corresponde each gap
% Author: Zeyu
% 2019-09-19 19:41:06 @ SUT
%% ====main_function====
    %data_path = 'D:\Wang_Zeyu\Documents\Academic_research\Huawei_Cup\Final\raw_data\file_1.xlsx';
    %[num,txt,raw] = xlsread(data_path);
    [~,txt,~] = xlsread(data_path);
    time_sequence = txt([2:end],1);
    begin_time_char = char(time_sequence(1));
    begin_time = datetime;
    
    begin_time.Year = str2num(begin_time_char(1:4));
    begin_time.Month = str2num(begin_time_char(6:7));
    begin_time.Day = str2num(begin_time_char(9:10));
    begin_time.Hour = str2num(begin_time_char(12:13));
    begin_time.Minute = str2num(begin_time_char(15:16));
    begin_time.Second = str2num(begin_time_char(18:19));
    
    record = [];
    j = 0;
    empty_position = 0;
    for i = 1:length(time_sequence)
        counting = datestr(datenum(begin_time), 'yyyy/mm/dd HH:MM:SS');
        raw_time = char(time_sequence(i));
        raw_time = raw_time(1:end - 5);
        if strcmp(counting,raw_time) == 0
            
            time = begin_time;
            time_counting = datestr(datenum(time), 'yyyy/mm/dd HH:MM:SS');
            count = 0;
            while strcmp(time_counting,raw_time) == 0
                time.Second = time.Second + 1;
                time_counting = datestr(datenum(time), 'yyyy/mm/dd HH:MM:SS');
                count = count + 1;
            end
            
            j = j + 1;
            record(j) = i;% save the next idx
            empty_position(j) = count;
            next = i + 1;
            new_begin = char(time_sequence(next));
            begin_time.Year = str2num(new_begin(1:4));
            begin_time.Month = str2num(new_begin(6:7));
            begin_time.Day = str2num(new_begin(9:10));
            begin_time.Hour = str2num(new_begin(12:13));
            begin_time.Minute = str2num(new_begin(15:16));
            begin_time.Second = str2num(new_begin(18:19));      
        else
            begin_time.Second = begin_time.Second + 1;
        end
    
    end
    gap_idx = record;
    %empty_position = empty_position;
end






