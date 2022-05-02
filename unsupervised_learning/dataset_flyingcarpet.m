function [data, colors] = dataset_flyingcarpet(noise,curviness)
%%%%%%%%%%%%%%%%%% Generate a flying carpet dataset %%%%%%%%%%%%%%%%%%%%%%%
% Description : Generate a colored 3D flying carper dataset of N points
%%%%%% Input:
% - noise (float) : desired noise level (ex: 0 - 10)
% - curviness (float) : desired curviness (ex: 0 - 10)
%%%%%% Output:
% - data (N x D, float) : the dataset (N samples of dimension D=3)
% - colors (N x 3, float) : RGB colors of the points
%%%%%% Author:
% antoine.deleforge@inria.fr (2021)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
K = 5;
Nx = 2^K+1;
Ny = 2^K+1;
N = Nx * Ny;

% Build the 2D map:
xgrid = ( (-Nx+1):2:(Nx-1) )/Nx;
ygrid = ( (-Ny+1):2:(Ny-1) )/Ny;
[x,y] = meshgrid(xgrid,ygrid);
x=x(:);
y=y(:);
data2D = [x,y]; % N x 2

% Define 2D colormap:
R=[1 0; 1 0];
G=[1 1; 0 0];
B=[0 0; 0 1];
R = interp2(R,K);
G = interp2(G,K);
B = interp2(B,K);
colors = cat(3,R,G,B); 
colors = reshape(colors,[N,3]);

% cmap = colormap(jet);
% colors_idx = (data2D(:,1)-min(data2D(:,1)))/...
%              (max(data2D(:,1)) - min(data2D(:,1)));
% colors_idx = round(1+63*colors_idx);
% colors = cmap(colors_idx,:);

% Curve the carpet in z dimension
z = curviness*(cos(pi*x)+sin(pi*y))/10;
data = [data2D,z]; % N x 3

% Scale y
data(:,2) = data(:,2).*(rand*1.5+0.5); % unif(0.5,2)

% Rotate
alpha = rand*2*pi;
beta = rand*2*pi;
gamma = rand*2*pi;
R = [ cos(alpha)*cos(beta), ...
      cos(alpha)*sin(beta)*sin(gamma) - sin(alpha)*cos(gamma), ...
      cos(alpha)*sin(beta)*cos(gamma) + sin(alpha)*sin(gamma); ...
      sin(alpha)*cos(beta), ...
      sin(alpha)*sin(beta)*sin(gamma) + cos(alpha)*cos(gamma), ...
      sin(alpha)*sin(beta)*cos(gamma) - cos(alpha)*sin(gamma); ...
      -sin(beta), cos(beta)*sin(gamma), cos(beta)*cos(gamma) ];
  
data = data*R';

% Translate:
data = data + rand(1,3)*4-2;

% Add noise:
data = data + noise*randn(N,3)/50;

end

