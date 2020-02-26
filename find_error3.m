function[corrected_data] = find_error3(new_data_path)
%USAGE: 'new_data_path' is the path of filled data for read & write
%       'corrected_data' is the corrected_data
% Author: Zeyu
% 2019-09-20 13:45:16 @ SUT
%% ====main_function====
    [~,~,raw] = xlsread(new_data_path);
    speed_sequence = raw([2:end],2);
    speed_sequence_mat = cell2mat(speed_sequence);
    idx = find(speed_sequence_mat==0);
    head = 1;
    
    while (idx(head)+1)<length(speed_sequence_mat)
        next = idx(head)+1;
        count = 1;
        while speed_sequence_mat(next) == 0
            count = count + 1;
            next = next + 1;
            if next >=length(speed_sequence_mat)
                break
            end
        end
    
        if count>=180
            for i = 0:(count-1)
                speed_sequence{idx(head) + i} = NaN;
            end
            head = head + count; 
        else
            head = head + count; 
        end     
    end
    raw([2:end],2) = speed_sequence;
    corrected_data = raw;
    xlswrite(new_data_path, raw , 'Sheet1')
    
end