function [centroids,Sigma,labels] = gmm_em(data, K, init_centroids,...
                                                    init_Sigma,niter)
%%%%%%%%%%%%%%%%%%% EM for Gaussian Mixture Models %%%%%%%%%%%%%%%%%%%%%%%%
% Description : clusters N D-dimensional data points into K classes.
%%%%%% Input:
% - data (N x D, float) : input data (N samples of dimension D)
% - K (int) : desired number of clusters
% - init_centroids (K x D, float) : initial positions of the K centroids
% - init_Sigma (K x D x D, float) : initial covariance matrices
% - niter (int) : number of iterations
%%%%%% Output:
% - centroids (K x D, float) : estimated positions of the K centroids
% - Sigma (K x D x D, float) : estimated covariance matrices
% - labels (N x 1, int) : label of each point in 1:K
%%%%%% Author:
% antoine.deleforge@inria.fr (2021)
% Auxiliary functions by Michael Chen (sth4nth@gmail.com)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[N,D] = size(data);

% Initialise parameters
centroids = init_centroids;
Sigma = init_Sigma;
weights = ones(K,1)/K; % K x 1 (equal weights)

% Intialize log probabilities
logproba = zeros(N,K);

for i=1:niter
    %%%%%%%%%%% EXPECTATION %%%%%%%%%%%
    % Update Log Probabilities p(Z_n=k|x_n)
    for k=1:K
        logproba(:,k) = log(weights(k)) +...
                        loggausspdf(data', ...
                                    centroids(k,:)', ...
                                    squeeze(Sigma(k,:,:))) ;
    end
    % Normalize probabilities
    logproba = logproba - logsumexp(logproba,2);
    proba = exp(logproba); % N x K
    
    % Update labels
    [~,labels] = max(proba,[],2);
    
    %%%%%%%%%%% MAXIMIZATION %%%%%%%%%%%
    sumProba = sum(proba,1)'; % K x 1
    
    % Update weights
    weights = sumProba/N;
    
    % Update centroids
    centroids = (proba'*data)./sumProba; % K x D
    
    % Update covariance matrices
    sqrtProba = sqrt(proba); % N x K
    for k=1:K
        data0 = sqrtProba(:,k).*(data - centroids(k,:)); % N x D
        Sigma(k,:,:) = data0'*data0/sumProba(k) + eye(D)*(1e-6);
    end
end

end

%%%%%%%%%%%%%%%%%%%%%%%%%% Auxiliary Functions %%%%%%%%%%%%%%%%%%%%%%%%%%%%
function y = loggausspdf(X, mu, Sigma)
d = size(X,1);
X = X-mu;
[U,p]= chol(Sigma);
if p ~= 0
    error('    ERROR: Sigma is not PD.');
end
Q = U'\X;
q = dot(Q,Q,1);  % quadratic term (M distance)
c = d*log(2*pi)+2*sum(log(diag(U)));   % normalization constant
y = -(c+q)/2;
end

function s = logsumexp(x, dim)
% Compute log(sum(exp(x),dim)) while avoiding numerical underflow.
%   By default dim = 1 (columns).
if nargin == 1
    % Determine which dimension sum will use
    dim = find(size(x)~=1,1);
    if isempty(dim), dim = 1; end
end

% subtract the largest in each column
y = max(x,[],dim);
x = x-y;
s = y + log(sum(exp(x),dim));
i = find(~isfinite(y));
if ~isempty(i)
    s(i) = y(i);
end
end
