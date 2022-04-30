function [data,true_centroids,true_labels] = dataset_square(dist)
%%%%%%%%%%%%%%%%%%%%%% Generate a square dataset %%%%%%%%%%%%%%%%%%%%%%%%%%
% Description : Generate a square dataset of N=1000 points in K=4 clusters
%%%%%% Input:
% - dist (float) : distance parameter
%%%%%% Output:
% - data (N x D, float) : the dataset (N=1000 samples of dimension D=2)
% - true_ centroids (K x D, float) : true positions of the K centroids
% - true_labels (N x 1, int) : true label of each point in 1:K
%%%%%% Author:
% antoine.deleforge@inria.fr (2021)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
N = 1000;
D = 2;
K = 4;
true_centroids = [0, 0;
             0, dist;
             dist, 0;
             dist, dist]; % K x D

data= zeros(N,D);
true_labels = zeros(N,1); 
for n=1:N
    true_labels(n) = randi(K);
    data(n,:) = randn(1,2) + true_centroids(true_labels(n),:);
end

end

