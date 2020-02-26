function[filled_data] = fill_data(raw_data_path,idx,empty_position,output_data_path)
%USAGE: 'raw_data_path' is the path of raw data 
%       'idx' is the idx of time gap position from function find_gap
%       'empty_position' is the num of gap point corresponde each gap from function find_gap
%       'output_data_path' is the output path of new file
% Author: Zeyu
% 2019-09-19 21:01:45 @ SUT
%% ====main_function====
    %[num,txt,raw] = xlsread(data_path);
    [~,~,raw] = xlsread(raw_data_path);
    for i = 1:length(idx)
        first_point_data = raw(idx(i),:);
        last_point_data = raw(idx(i)+1,:);
        num_of_empty = empty_position(i);
     
        velocity = linspace(first_point_data{2}, last_point_data{2}, num_of_empty);
        longitude = linspace(first_point_data{6}, last_point_data{6}, num_of_empty);
        latitude = linspace(first_point_data{7}, last_point_data{7}, num_of_empty);
        engine_speed = (first_point_data{8} + last_point_data{8}) * 0.5;
        
        %velocity = (first_point_data{2} + last_point_data{2}) * 0.5;
        
        
        fill_content = cell(num_of_empty,14);
        
        for j = 1:length(fill_content(:,1))
            fill_content{j,2} = velocity(j);
            fill_content{j,6} = longitude(j);
            fill_content{j,7} = latitude(j);
            fill_content{j,8} = engine_speed;
        end
        
        raw = [raw([1:idx(i)],:); fill_content ;raw([idx(i)+1:end],:)];
        idx =idx + num_of_empty; 
        disp(i)
    end
    filled_data = raw;
    xlswrite(output_data_path, raw , 'Sheet1')
    
end