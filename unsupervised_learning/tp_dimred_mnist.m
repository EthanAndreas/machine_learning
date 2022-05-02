%% Q1

[data, colors] = dataset_flyingcarpet(0,0);
figure(1); movegui('northwest');
scatter3(data(:,1),data(:,2),data(:,3),5,colors);
axis equal; axis([-4,4,-4,4,-4,4]);
