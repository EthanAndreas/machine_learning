function [data,true_centroids,true_labels] = dataset_flower(K)
%%%%%%%%%%%%%%%%%%%%%% Generate a flower dataset %%%%%%%%%%%%%%%%%%%%%%%%%%
% Description : Generate a flower dataset of N points and K centroids
%%%%%% Input:
% - K (int) : desired number of clusters
%%%%%% Output:
% - data (N x D, float) : the dataset (N samples of dimension D=2)
% - true_ centroids (K x D, float) : true positions of the K centroids
% - true_labels (N x 1, int) : true label of each point in 1:K
%%%%%% Author:
% antoine.deleforge@inria.fr (2021)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
N = 3000;
D = 2;
r_petal = 4;
sigma2_center = 1;
lambda1 = 4;
lambda2 = 0.4;

% Centroids
true_centroids = zeros(K,D);
for k=2:K
    theta = 2*pi*(k-2)/(K-1);
    true_centroids(k,1) = r_petal*cos(theta);
    true_centroids(k,2) = r_petal*sin(theta);
end

% Covariance matrices
Sigma = zeros(K,D,D);
Sigma(1,:,:) = sigma2_center*eye(D);
for k=2:K
    theta = 2*pi*(k-2)/(K-1);
    eig_vec1 = [cos(theta);sin(theta)];
    eig_vec2 = [-sin(theta);cos(theta)];
    Sigma(k,:,:) = lambda1*(eig_vec1*eig_vec1') + ...
                   lambda2*(eig_vec2*eig_vec2');
end

% Generate
data = zeros(N,D);
true_labels = zeros(N,1); 
for n=1:N
    true_labels(n) = randi(K);
    data(n,:) = multigaussrnd(true_centroids(true_labels(n),:),...
                       squeeze(Sigma(true_labels(n),:,:)));
end

end

function x = multigaussrnd(mu,Sigma)
%%%%%%%%%% Multivariate Gaussian Random Number Generator %%%%%%%%%%%%%%%%%%
%%%%%% Input:
% - mu (1 x D float) : mean
% - Sigma (D x D float) : covariance
%%%%%% Output:
% - x (1 x D float) : random  vector
%%%%%% Author:
% antoine.deleforge@inria.fr (2021)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
D = size(mu,2);
x = randn(1,D); % Start with standard Gaussians
R = chol(Sigma); % Cholesky factorisation (D x D float)
x = x*R + mu;
end

