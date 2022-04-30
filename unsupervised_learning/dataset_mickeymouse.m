function [data,true_centroids,true_labels] = dataset_mickeymouse(ratio)
%%%%%%%%%%%%%%%%%%% Generate a Mickey Mouse dataset %%%%%%%%%%%%%%%%%%%%%%%
% Description : Generate a Mickey Mouse dataset of N points
%%%%%% Output:
% - data (N x D, float) : the dataset (N samples of dimension D=2)
% - true_ centroids (K x D, float) : true positions of the K centroids
% - true_labels (N x 1, int) : true label of each point in 1:K
%%%%%% Author:
% antoine.deleforge@inria.fr (2021)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
N = 2000;
D = 2;
head_radius = 12;
ear_radius = 12/ratio;
true_centroids = [0, 0;
                  -head_radius, head_radius;
                  head_radius, head_radius]; % K x D

data = zeros(N,D);
true_labels = zeros(N,1); 
for n=1:N
    cointoss1=randi(2);
    if(cointoss1==1) % Heads
        true_labels(n)=1;
        data(n,:) = head_radius/2*randn(1,2) + true_centroids(true_labels(n),:);
    else
        cointoss2=randi(2);
        true_labels(n)=1+cointoss2;       
        data(n,:) = ear_radius/2*randn(1,2) + true_centroids(true_labels(n),:);        
    end
end

end

