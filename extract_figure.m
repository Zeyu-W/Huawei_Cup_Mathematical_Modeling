function[figure] = extract_figure(PGA)
%USAGE: 'PGA' is one PGA  segment
%       'figure' return 14 figures from correspondent PGA segment
% Author: Zeyu
% 2019-09-21 9:41:48 @ SUT
%% ====main_function====
    time= length(PGA);
    figure(1) = time;
    max_speed = max(PGA)/3.6;
    figure(2) = max_speed;
    
    for i = 1:length(PGA)-1
        acceleration_sequence(i) = PGA(i+1)/3.6 -  PGA(i)/3.6;        
    end
    max_acceleration = max(acceleration_sequence);
    figure(3) = max_acceleration;
    max_deceleration = min(acceleration_sequence);
    figure(4) = max_deceleration;
    
    mean_speed = sum(PGA)/time/3.6;
    figure(5) = mean_speed;
    mean_moving_speed = sum(PGA)/length(find(PGA))/3.6;
    figure(6) = mean_moving_speed;
    
    if  isempty(find(acceleration_sequence > 0.1))
        figure(7) = 0;
        figure(10) = 0;
        figure(13) = 0;
    else
        mean_acceleration = sum(acceleration_sequence(find(acceleration_sequence > 0.1)))/length(acceleration_sequence(find(acceleration_sequence > 0.1)));
        figure(7) = mean_acceleration;
        acceleration_time_proportion =  length(find(acceleration_sequence > 0.1))/time;
        figure(10) = acceleration_time_proportion;
        acceleration_std = std(acceleration_sequence(find(acceleration_sequence > 0.1)),1);
        figure(13) = acceleration_std;
    end
    
    if isempty(find(acceleration_sequence < -0.1))
        figure(8) = 0;
        figure(11) = 0;
        figure(14) = 0;
    else
        mean_deceleration = sum(acceleration_sequence(find(acceleration_sequence < -0.1)))/length(acceleration_sequence(find(acceleration_sequence < -0.1)));
        figure(8) = mean_deceleration;
        deceleration_time_proportion =  length(find(acceleration_sequence < -0.1))/time;
        figure(11) = deceleration_time_proportion;
        deceleration_std = std(acceleration_sequence(find(acceleration_sequence < -0.1)),1);
        figure(14) = deceleration_std;
    end
    
    idle_time_proportion = (length(find(PGA==0)) - 1) / time;
    figure(9) = idle_time_proportion;
    
    speed_std = std(PGA/3.6,1);
    figure(12) = speed_std;

    idx_zero = find(PGA == 0);
    idx_acc = find((acceleration_sequence <= 0.1) & (acceleration_sequence >= 0));
    %idx_acc = [idx_acc' ; idx_acc(end) + 1];
    %setdiff(idx_acc,idx_zero);
    uniform_speed_pro = length(setdiff(idx_acc,idx_zero))/time;
    figure(15) = uniform_speed_pro;

end
