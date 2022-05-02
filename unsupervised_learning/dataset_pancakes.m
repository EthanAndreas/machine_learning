function [data,true_centroids,true_labels] = dataset_pancakes(K)
% Description : Generate a pancake dataset of N points and K centroids
%%%%%% Input:
% - K (int) : desired number of clusters
%%%%%% Output:
% - data (N x D, float) : the dataset (N samples of dimension D=2)
% - true_ centroids (K x D, float) : true positions of the K centroids
% - true_labels (N x 1, int) : true label of each point in 1:K
N = 2000;
D = 2;
thickness = 1;
spacing = 7;
width = 10;
offset = 3;

true_centroids = zeros(K,D);
true_centroids(:,1) = randn(K,1)*offset;
true_centroids(:,2) = (1:K)*thickness*spacing;

data = zeros(N,D);
true_labels = zeros(N,1); 
for n=1:N
    true_labels(n) = randi(K);
    data(n,1) = randn*width + true_centroids(true_labels(n),1);
    data(n,2) = randn*thickness + true_centroids(true_labels(n),2);
end

end

