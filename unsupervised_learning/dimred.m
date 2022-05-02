%%% Load MNIST
MNIST = load('mnist_test.csv');
labels = MNIST(:,1);
data = MNIST(:,2:end);
[N,D] = size(data);

tic;
%%% Run k-means++ with K=10
K = 10;
centroids = kmeansplusplus_init(data, K);
centroids = kmeans(data, K, centroids, 10);

% Show runtime
fprintf(1,'K-means++ ran for %g seconds\n',toc);

%%% Visualize the resulting centroids
fig=figure;clf(fig);
visualize_MNIST(fig,centroids,2,5,false);

tic;
%%% Run gmm_em starting from  the k-means solution;
Sigma = zeros(K,D,D);
for k=1:K
    Sigma(k,:,:)=eye(D); % Identity matrix
end

centroids = gmm_em(data, K, centroids, Sigma, 5);

% Show runtime
fprintf(1,'GMM EM ran for %g seconds\n',toc);

%%% Visualize the resulting centroids
fig=figure;clf(fig);
visualize_MNIST(fig,centroids,2,5,false);