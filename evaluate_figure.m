function[figure_vector] = evaluate_figure(time_win)
    time= length(time_win);
    for i = 1:length(time_win)-1
        acceleration_sequence(i) = time_win(i+1)/3.6 -  time_win(i)/3.6;        
    end
    
    
    if  isempty(find(acceleration_sequence > 0.1))
        figure_vector(1) = 0;
    else
        acceleration_time_proportion =  length(find(acceleration_sequence > 0.1))/time;
        figure_vector(1) = acceleration_time_proportion;
    end
    
    
    idx_zero = find(time_win == 0);
    idx_acc = find((acceleration_sequence <= 0.1) & (acceleration_sequence >= 0));
    %idx_acc = [idx_acc' ; idx_acc(end) + 1];
    %setdiff(idx_acc,idx_zero);
    uniform_speed_pro = length(setdiff(idx_acc,idx_zero))/time;
    figure_vector(2) = uniform_speed_pro;
    
    idle_time_proportion = (length(find(time_win==0)) - 1)/time;
    figure_vector(3) = idle_time_proportion;
    
    
    if isempty(find(acceleration_sequence < -0.1))
        figure_vector(4) = 0;
    else
        deceleration_time_proportion =  length(find(acceleration_sequence < -0.1))/time;
        figure_vector(4) = deceleration_time_proportion;
    end
    
    
    mean_speed = sum(time_win)/time/3.6;
    figure_vector(5) = mean_speed;
end