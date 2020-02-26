
raw_data_path = {'D:\Wang_Zeyu\Documents\Academic_research\Huawei_Cup\Final\raw_data\file_1.xlsx'
                 'D:\Wang_Zeyu\Documents\Academic_research\Huawei_Cup\Final\raw_data\file_2.xlsx'
                 'D:\Wang_Zeyu\Documents\Academic_research\Huawei_Cup\Final\raw_data\file_3.xlsx'
                };
    
output_data_path = {'D:\Wang_Zeyu\Documents\Academic_research\Huawei_Cup\Final\new_data_1.xlsx'
                    'D:\Wang_Zeyu\Documents\Academic_research\Huawei_Cup\Final\new_data_2.xlsx'
                    'D:\Wang_Zeyu\Documents\Academic_research\Huawei_Cup\Final\new_data_3.xlsx'
                    };
for i = 1:length(raw_data_path)
    [gap_idx,empty_position] = find_gap(raw_data_path{i});
    fill_data(raw_data_path{i},gap_idx,empty_position,output_data_path{i});
    %clear
    disp(i)
end
