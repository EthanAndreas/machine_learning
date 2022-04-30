function visualize_2Dclustering(fig,data,centroids,labels,Sigma)
%%%%%%%%%%%%%%%%%%%%% Visualize a 2D clustering  %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% Input:
% - fig (handle) : figure handle to use for display
% - data (N x D, float) : input data (N samples of dimension D)
% - [OPTIONAL] centroids (K x D, float) : positions of the K centroids
% - [OPTIONAL] labels (N x 1, int) : label of each point in 1:K
% - [OPTIONAL] Sigma (K x D x D, float) : covariance matrices for ellipses
%%%%%% Author:
% antoine.deleforge@inria.fr (2021)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clf(fig);
hold on;

% Plot data
if exist('labels','var')
    scatter(data(:,1),data(:,2),10,labels);
else
    scatter(data(:,1),data(:,2));
end

% Plot centroids
if exist('centroids','var') && ~isempty(centroids)
    scatter(centroids(:,1),centroids(:,2),80,[1,1,0],'filled','^',...
                                             'MarkerEdgeColor','k');
end
                                     
% Plot Gaussian ellipsoids from Sigma
%   Inspired from: https://www.mathworks.com/matlabcentral/fileexchange/...
%                46324-gaussian-ellipses-constant-probability-curves
if exist('Sigma','var')
    K = size(Sigma,1);
    for k=1:K
        % Calculate principal directions(PD) and variances (PV) of Sigma_k
        [PD,PV]=eig(squeeze(Sigma(k,:,:)));
        PV=sqrt(diag(PV));
        
        % Build ellipses
        theta=linspace(0,2*pi,100)'; % P x 1
        elpt0 = [cos(theta),sin(theta)]*diag(PV)*PD';
        elpt1 = 1*elpt0 + centroids(k,:);
        elpt2 = 2*elpt0 + centroids(k,:);
        %elpt3 = 3*elpt0 + centroids(k,:);
        plot(elpt1(:,1),elpt1(:,2),'k','LineWidth',2)
        plot(elpt2(:,1),elpt2(:,2),'k','LineWidth',1)
        %plot(elpt3(:,1),elpt3(:,2),'k','LineWidth',1)
    end
end

axis equal;
colormap jet;
end

