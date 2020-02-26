function[PGA_idx] = extract_PGA(new_data_path)
%USAGE: 'new_data_path' is the path of pre-processed data for read & write
%       'PGA_idx' is the idx of PGA in data file
% Author: Zeyu
% 2019-09-21 9:41:48 @ SUT
%% ====main_function====
    [~,~,raw] = xlsread(new_data_path);
    speed_sequence = raw([2:end],2);
    speed_sequence_mat = cell2mat(speed_sequence);
    idx = find(speed_sequence_mat==0);
    head = 1;
    PGA_count = 1;
    PGA_idx = {};
    
    while (idx(head)+1)<length(speed_sequence_mat)
        next = idx(head)+1;
        count_zero = 1;
        count_num = 0;
        while speed_sequence_mat(next) == 0
            count_zero = count_zero + 1;
            next = next + 1;
            if next >=length(speed_sequence_mat)
                break
            end
        end
        
        if next >=length(speed_sequence_mat)
            break
        end
        
        while (~(speed_sequence_mat(next) == 0) & ~(isnan(speed_sequence_mat(next))))
            count_num = count_num + 1;
            next = next + 1;            
        end
        
        during = count_zero + count_num;
        during = [idx(head),idx(head)+during];
        PGA_idx{PGA_count} = during;
        
        head = head + count_zero;
        PGA_count = PGA_count + 1;
    end   
    
end