function[corrected_data] = find_error4(new_data_path)
%USAGE: 'new_data_path' is the path of filled data for read & write
%       'corrected_data' is the corrected_data
% Author: Zeyu
% 2019-09-20 15:37:52 @ SUT
%% ====main_function====
    [~,~,raw] = xlsread(new_data_path);
    speed_sequence = raw([2:end],2);
    speed_sequence_mat = cell2mat(speed_sequence);
    idx = find(speed_sequence_mat==0);
    head = 1;
    
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
        
        while ~(speed_sequence_mat(next) == 0)
            count_num = count_num + 1;
            next = next + 1;            
        end
        
        during = count_zero + count_num;
        during = [idx(head):idx(head)+during];
        
        if max(speed_sequence_mat(during)) < 10 & length(speed_sequence_mat(during)) < 180
            speed_sequence_mat(during) = 0;
        end
        head = head + count_zero;
    end   
    raw([2:end],2) = mat2cell(speed_sequence_mat,ones(1,length(speed_sequence_mat)),[1]);
    corrected_data = raw;
    xlswrite(new_data_path, raw , 'Sheet1')
    
end