function visualize_MNIST(fig,data,X,Y,rnd)
%%%%%%%%%%%%%%%%%%%%% Visualize MNIST  %%%%%%%%%%%%%%%%%%%%%%%%%
% Description : Visualize X*Y random images from a MNIST subset
%%%%%% Input:
% - fig (handle) : figure handle to use for display
% - data (N x D, float) : MNIST data (usually D=28*28)
% - X, Y (int) : Display grid size
% - rnd (bool) : randomize images if true
%%%%%% Author:
% antoine.deleforge@inria.fr (2021)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clf(fig);
[N,D] = size(data);
px = round(sqrt(D)); % images have px*px pixels
if rnd
    subMNIST = reshape(data(randperm(N,X*Y),:),[X*Y,px,px]);    
else
    subMNIST = reshape(data(1:X*Y,:),[X*Y,px,px]);
end

for p=1:(X*Y)
    subplot(X,Y,p);
    imagesc(squeeze(subMNIST(p,:,:))');
    set(gca,'XTickLabel',[]);
    set(gca,'YTickLabel',[]);
    axis off;
    axis equal;
end

colormap gray;

end

