clear all;
close all;

%% clustering

%% Code Q1
% [data, true_centroids, true_labels] = dataset_square(10);

% fig1 = figure('Name','DATA');
% clf(fig1);
% movegui('northwest');
% visualize_2Dclustering(fig1,data);
% pause; 

% fig2 = figure('Name','GROUND TRUTH');
% clf(fig2);
% movegui('southwest');
% visualize_2Dclustering(fig2,data,true_centroids,true_labels);
% pause;

%% Q1
% on voit qu'il y a 4 clusters et que le paramètre de la fonction 
% dataset_square représente la distance le centre des clusters et les
% coins du carré

%% Code Q2
% [data,true_centroids,true_labels] = dataset_mickeymouse(10);
% fig1 = figure('Name','DATA');
% clf(fig1);
% movegui('northwest');
% visualize_2Dclustering(fig1,data);
% pause;

% [data,true_centroids,true_labels] = dataset_pancakes(1);
% fig1 = figure('Name','DATA');
% clf(fig1);
% movegui('northwest');
% visualize_2Dclustering(fig1,data);
% pause;

% [data,true_centroids,true_labels] = dataset_flower(10);
% fig1 = figure('Name','DATA');
% clf(fig1);
% movegui('northwest');
% visualize_2Dclustering(fig1,data);
% pause;

%% Q2
% Dataset mickey : le paramètre ration correspond au regroupement
% des points des oreilles
% Dataset pancake : le paramètre K correspond au nombre de crèpes
% Dataset flower : le paramètre K correspond au regroupement autour
% des branches de la fleur

%% Code Q3

% [data, ~, init_labels] = dataset_square(10);
% K = 4;
% max_steps = 30;
% iter_per_step = 1;
% 
% % initialize parameters
% N = size(data,1);
% centroids = data(randperm(N,K),:);
%  
% 
% % main loop of clustering
% labels = 0; 
% new_labels = 0;
% fig3 = figure('Name','CLUSTERING');
% clf(fig3);
% movegui('northeast');
% 
% for i = 1:max_steps
%     
%     % run k-means for niter iterations [Partie II]
%     [new_centroids,new_labels] = kmeans(data, K, centroids, iter_per_step);
%     
%     % early stopping: stop the loop if labels have not changed
%     if(all(new_labels == labels))
%         break;
%     end
%     
%     % visualize clustering in current iteration
%     visualize_2Dclustering(fig3,data,centroids,new_labels); pause;    
%     visualize_2Dclustering(fig3,data,new_centroids,new_labels); pause;
%     
%     %%%% Update labels and parameters
%     labels = new_labels;
%     centroids = new_centroids;
% end

%% Q3 / Q4
% il faut 2 à 6 itérations pour arriver au bon résultat
% 4/5 fois cela marche c'est assez rare que cela ne fonctionne pas
% cela échoue dans le cas où les centres de départs sont mal choisis
% (ex : deux au même endroit sur le même cluster)
% kmeans dépend de l'initialisation

%% Q5

% [data, ~, init_labels] = dataset_square(10);
% [data, ~, init_labels] = dataset_mickeymouse(3);
% [data, ~, init_labels] = dataset_pancakes(7);
% [data, ~, init_labels] = dataset_flower(9);
% K = 4;
% K = 3;
% K = 7;
% K = 9;
% max_steps = 30;
% iter_per_step = 1;
% 
% % initialize parameters
% N = size(data,1);
% centroids = kmeansplusplus_init(data, K);
%  
% % main loop of clustering
% labels = 0; 
% new_labels = 0;
% fig3 = figure('Name','CLUSTERING');
% clf(fig3);
% movegui('northeast');
% 
% for i = 1:max_steps
%     
%     % run k-means for niter iterations [Partie II]
%     [new_centroids,new_labels] = kmeans(data, K, centroids, iter_per_step);
%     
%     % early stopping: stop the loop if labels have not changed
%     if(all(new_labels == labels))
%         break;
%     end
%     
%     % visualize clustering in current iteration
%     visualize_2Dclustering(fig3,data,centroids,new_labels); pause;    
%     visualize_2Dclustering(fig3,data,new_centroids,new_labels); pause;
%     
%     %%%% Update labels and parameters
%     labels = new_labels;
%     centroids = new_centroids;
% end

%% Q5/Q6/Q7/Q8
% on choisit les centres de façon optimale, la convergence est donc 
% beaucoup plus rapide (2-3 itérations) dans le cas où les clusters 
% sont bien séparés dans le cas contraire on obtient un résultat bien
% plus satisfaisant mais c'est beaucoup plus lent
% pour kmeans tous les cluster font la même taille (mickeymouse)
% kmeans est une méthode isotrope et elle ne fait pas la différence 
% entre les axes de l'espace

%% Q9 / Q10 / Q11

% % [data, ~, init_labels] = dataset_square(10);
% % [data, ~, init_labels] = dataset_mickeymouse(3);
% % [data, ~, init_labels] = dataset_pancakes(7);
% [data, ~, init_labels] = dataset_flower(9);
% % K = 4;
% % K = 3;
% % K = 7;
% K = 9;
% max_steps = 30;
% iter_per_step = 20;
% 
% % initialize parameters
% N = size(data,1);
% centroids = kmeansplusplus_init(data, K);
% 
% D = size(data,2);
% Sigma = zeros(K,D,D);
% for k = 1:K
%     Sigma(k,:,:) = eye(D);
% end
%  
% % main loop of clustering
% labels = 0; 
% new_labels = 0;
% fig3 = figure('Name','CLUSTERING');
% clf(fig3);
% movegui('northwest');
% 
% for i = 1:max_steps
%     
%     % run k-means for niter iterations [Partie II]
%     [new_centroids,new_Sigma,new_labels] = gmm_em(data, K, centroids, Sigma, iter_per_step);
%     
%     % early stopping: stop the loop if labels have not changed
%     if(all(new_labels == labels))
%         break;
%     end
%     
%     % visualize clustering in current iteration
%     visualize_2Dclustering(fig3,data,centroids,new_labels,Sigma); pause;    
%     visualize_2Dclustering(fig3,data,new_centroids,new_labels,new_Sigma); pause;
%     
%     %%%% Update labels and parameters
%     labels = new_labels;
%     centroids = new_centroids;
%     Sigma = new_Sigma;
% end

%% Q12 / Q13

% MNIST = load('mnist_test.csv');
% labels = MNIST(:,1); data = MNIST(:,2:end);
