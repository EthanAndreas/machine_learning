function init_centroids = kmeansplusplus_init(data, K)
%%%%%%%%%%%%%%%%%%%% k-means clustering algorithm %%%%%%%%%%%%%%%%%%%%%%%%%
% Description : k-means++ initialization
%%%%%% Input:
% - data (N x D, float) : input data (N samples of dimension D)
% - k (int) : desired number of clusters
%%%%%% Output:
% - init_centroids (K x D, float) : initial positions of the K centroids
%%%%%% Author:
% antoine.deleforge@inria.fr (2021)
% Inspired from Laurent Sorber (Laurent.Sorber@cs.kuleuven.be) 2013
%   https://fr.mathworks.com/matlabcentral/fileexchange/28804-k-means
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
N = size(data,1);

% The first centroid is a random point in the datset
init_centroids = data(randi(N),:); % 1 x D
labels = ones(N,1);
for i = 2:K
    % Compute squared distances from the data points to their respective
    % centroids
    dist = data - init_centroids(labels,:); % N x D
    
    % Pick the next centroid at random from the data points with
    % probability proportional do the squared distances
    cdist = cumsum(dot(dist,dist,2)); % N x 1
    % Simulate a multinomial variable
    init_centroids(i,:) = data(find(cdist/cdist(end)>rand,1),:);
    
    % Update Labels (nearest centroid)
    [~,labels] = max(2*real(data*init_centroids') - ... % N x K
                     dot(init_centroids,init_centroids,2)',[],2);
end
end

