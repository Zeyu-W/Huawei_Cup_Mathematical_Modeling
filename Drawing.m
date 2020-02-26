%% ========= plot_PGA =========
for i = 1:1:4
    subplot(2,2,i)
    plot(PGA{1}{i},string{i})
    xlabel('时间:s')
    ylabel('速度:km/h')
end
%% ========= plot_PGA_in_different_class =========
for i = 1:1:4
for i = 1:1:10
    subplot(2,5,i)
    plot(class_1{i})
    xlabel('时间:s')
    ylabel('速度:km/h')
end
%% ========= plot_3d_class_in_kmeans=========
for i = 1:1:4
idx = find(id == 1);
class1 = pcaData1(idx,:);
plot3(class1(:,1),class1(:,2),class1(:,3),'b.','MarkerSize',5)
hold on 

idx = find(id == 2);
class2 = pcaData1(idx,:);
plot3(class2(:,1),class2(:,2),class2(:,3),'g*','MarkerSize',5)
hold on

idx = find(id == 3);
class3 = pcaData1(idx,:);
plot3(class3(:,1),class3(:,2),class3(:,3),'r+','MarkerSize',5)
hold on

idx = find(id == 4);
class4 = pcaData1(idx,:);
plot3(class4(:,1),class4(:,2),class4(:,3),'yo','MarkerSize',5)
hold on

idx = find(id == 5);
class5 = pcaData1(idx,:);
plot3(class5(:,1),class5(:,2),class5(:,3),'cs','MarkerSize',5)
grid on
hold on
%% ========= plot_kmeans_classification evaluation =========
for i = 1:1:4
biaoji =kmeans(pcaData1, 5,'replicates',500)
silhouette(pcaData1,biaoji,'sqeuclidean')
end




for i = 1:length(under_evaluated)-1
    under_evaluated_acceleration_sequence(i) = under_evaluated(i+1)/3.6 -  under_evaluated(i)/3.6;
end
histo_v = hist(under_evaluated,20);
max_v = max(under_evaluated);
v_u = linspace(0,max_v,20);

histo_a = hist(under_evaluated_acceleration_sequence,20);
max_a = max(under_evaluated_acceleration_sequence);
min_a = min(under_evaluated_acceleration_sequence);
a_u = linspace(min_a,max_a,20);

max_a_num = max(histo_a);
for i = 1:length(histo_v)
    for j =1:length(histo_a)
        map_pga(i,j) = histo_v(i) * (histo_a(j)/max_a_num);
    end
end

surf(v,a,map_pga)
xlabel('速度:m/s')
ylabel('加速度:m/s^2')

subplot(1,2,1)
surf(v_final,a_final,map_pga)
xlabel('速度:m/s')
ylabel('加速度:m/s^2')
title('代表行驶工况的SAFD分布图')

subplot(1,2,2)
surf(v_u,a_u,map)
xlabel('速度:m/s')
ylabel('加速度:m/s^2')
title('待评估数据的SAFD分布图')


for i = 1:1:2
    subplot(1,2,i)
    plot(PGA{1}{i},string{i})
    xlabel('时间:s')
    ylabel('速度:km/h')
end
