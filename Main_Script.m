%% ========= Preprocessed_data_path =========
data_path = {'D:\Wang_Zeyu\Documents\Academic_research\Huawei_Cup\Final\new_data_1.xlsx'
             'D:\Wang_Zeyu\Documents\Academic_research\Huawei_Cup\Final\new_data_2.xlsx'
             'D:\Wang_Zeyu\Documents\Academic_research\Huawei_Cup\Final\new_data_3.xlsx'
              };
%% ========= Extract_PGA =========
PGA = {};          
for i = 1:length(data_path)
    idx = extract_PGA(data_path{i});
    [~,~,raw] = xlsread(data_path{i});
    speed_sequence = raw([2:end],2);
    speed_sequence_mat = cell2mat(speed_sequence);
    temp = {};
    for j = 1:length(idx)
        temp{j} = speed_sequence_mat([idx{j}(1):idx{j}(2)]);
        if isnan(temp{j}(end))
            temp{j}(end) = 0;
        end
    end
    PGA{i} = temp;
end

%% ========= Extract_PGA_figure =========
PGA_figure = {};
for i = 1:length(PGA)
    for j = 1:length(PGA{i})
        figure = extract_figure(PGA{i}{j});
        PGA_figure{i}{j} = figure;
    end  
end

%% ========= Combine_all_PGA_figure_in_one_array =========
count = 1;
for i = 1:length(PGA)
    for j = 1:length(PGA{i})
        all_PGA_figure_array(count,:) = PGA_figure{i}{j};
        count = count +1;
    end  
end

%% ========= Normalize_PGA_figure_array =========
anv = mean(all_PGA_figure_array);
stand = std(all_PGA_figure_array,0) .* std(all_PGA_figure_array,0);
nomoralized_all_PGA_array = [];
for i = 1:length(all_PGA_figure_array(1,:))
    for j = 1:length(all_PGA_figure_array(:,1))
        nomoralized_all_PGA_array(j,i) = (all_PGA_figure_array(j,i) - anv(i))/stand(i);
    end
end

%% ========= Dimensionality_Reduction_by_PCA =========
[COEFF,SCORE,latent]=pca(nomoralized_all_PGA_array);
pcaData1=SCORE(:,1:3);

%% ========= Cluster_analysis =========
[id,c,sumD,D]=kmeans(pcaData1, 5,'replicates',2000);
%% ========= Find_the_typical_PGA =========
positon = {};
for i = 1:length(D(1,:))
    sorted_D = sort(D(:,i));
    distance = sorted_D(1:10);% min_oeder
    idx = [];
    for j = 1:length(distance)
        idx(j) = find(D(:,i) == distance(j));
    end
    positon{i} =idx;
end
count = 1;
for i = 1:length(PGA)
    for j = 1:length(PGA{i})
        all_PGA_array{count} = PGA{i}{j};
        count = count +1;
    end  
end
class = {};
for i = 1:length(positon)
    class{i} = all_PGA_array(positon{i});
end

%% ========= Generate_the_DC_curve_0 =========
class_1 = class{1};
class_2 = class{2};
class_3 = class{3};
class_4 = class{4};
class_5 = class{5};
%% ========= Evaluation =========
std_figure_vector = evaluate_figure(final);
for i = 1:length(data_path)
    [~,~,raw] = xlsread(data_path{i});
    speed_sequence = raw([2:end],2);
    speed_sequence_mat = cell2mat(speed_sequence);
    head = 1;
    time_win_num = 1;
    distance = [];
    while (head + length(final) - 1) < length(speed_sequence_mat) 
        tail = head + length(final) - 1;
        figure_vector = evaluate_figure(speed_sequence_mat(head:tail));  
        distance(time_win_num) = norm(std_figure_vector - figure_vector);
        head = head + 60;% step_size
        time_win_num = time_win_num + 1;        
    end
    all_distance{i} =distance;
end

% count = 1;
% for i = 1:length(class_1)
%     for j = 1:length(class_2)
%         for l = 1:length(class_4)
%             for m = 1:length(class_5)
%                 combine{count} = cat(1,class_1{i},class_2{j},class_4{l},class_5{m});
%                 count = count + 1; 
%             end
%         end
%     end
% end
% 
% count = 1;
% for i = 1:length(combine)
%     if ((length(combine{i})<=1300) & (length(combine{i})>=1200))
%         selected{count} = combine{i};
%         count = count + 1; 
%     end
% end
