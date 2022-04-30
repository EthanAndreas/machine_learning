function [centroids,labels] = q3_kmeans(data, K, init_centroids, niter)
    %%%%%% Input:
    % - data (N x D, float) : input data (N samples of dimension D)
    % - K (int) : desired number of clusters
    % - init_centroids (K x D, float) : initial positions of the K centroids
    % - niter (int) : number of iterations
    %%%%%% Output:
    % - centroids (K x D, float) : output positions of the K centroids
    % - labels (N x 1, int) : label of each point in 1:K
    
    [n,m] = size(data);
    centroids = init_centroids;
 
    for i=1:niter
        %%% Update labels:
        % compute the centroid-to-point distance matrix (N x K)
        % euclidean distance
        diff = (reshape(data,[n,1,m]) - reshape(centroids,[1,K,m])).^2;
        % sum of euclidean distance
        % 3 is the third dimension of the cube (k,n,m) which is m
        dist = sum(diff,3);
        
        % other method
%         dist = zeros(N,K);
%         for k=1:K
%             for l=1:n
%                 dist(l,k) = norm(data(l,:)) - centroids(k,:);
%             end
%         end
        
        % assign points to their closest centroid
        [~,labels] = min(dist,[],2);
        
        
        %%% Update centroids
        for k=1:K
            centroids(k,:) = mean(data(labels == k, :), 1);
        end
    end
end