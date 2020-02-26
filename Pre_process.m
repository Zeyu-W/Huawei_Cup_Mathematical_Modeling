data_path = {'D:\Wang_Zeyu\Documents\Academic_research\Huawei_Cup\Final\new_data_1.xlsx'
             'D:\Wang_Zeyu\Documents\Academic_research\Huawei_Cup\Final\new_data_2.xlsx'
             'D:\Wang_Zeyu\Documents\Academic_research\Huawei_Cup\Final\new_data_3.xlsx'
              };
for i = 2:length(data_path)
    find_error2(data_path{i});
    disp('error2_finished')
    find_error4(data_path{i});
    disp('error4_finished')
    find_error3(data_path{i});
    disp('error3_finished')
    disp(i)
end
