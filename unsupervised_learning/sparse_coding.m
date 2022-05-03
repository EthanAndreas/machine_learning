function z = sparse_coding( D, x, epsilon, smax)
%%%%%%%%%%%%%%%%%%%%%% Sparse Coding Algorithm %%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Find a sparse vector s such that x ~ D*z. 
%  More precisely, we intend to solve:
%
%      min  |x-D*z|_2     s.t. : |z|_0 <= smax 
%      z                    or : |x - D*z|_2 <= epsilon
%%%%%% INPUT %%%%%%
% - D (N*K) : Set of K N-dimensional atoms (Dictionary)
% - x (N*1) : Input N-dimensional signal
% - epsilon (double) : Target reconstruction error
% - smax (int) : Maximum number of nonzero element in z
%
%%%%%% OUTPUT %%%%%
% - z (K*1) : Output sparse coding vector
%
%%%%%% TP Telecom Physique Strasbourg 2021
%%%%%% Antoine Deleforge (antoine.deleforge@inria.fr)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[N,K] = size(D); % Dictionary size

% -- Intitialize --
r           = x; % Residual  (Initialized to x)
z           = zeros(K,1); % Sparse coding vector
indx_set    = zeros(smax,1); % Set of selected indexes
atom_set    = zeros(N,smax); % Set of selected atoms

converged = false;
iter=0;
while ~converged
    iter = iter + 1;
    % -- Step 1: find new index and atom to add
    Dr          = conj(D)'*r; % Scalar products
    [~,ind_new] = max(abs(Dr)); % Find atom maximizing abs. scalar product
    indx_set(iter)    = ind_new; % Insert new index in the set
    atom_set(:,iter)   = D(:,ind_new); % Insert new atom in the set
    
    % -- Step 2: update coding and residual
    z_T = atom_set(:,1:iter)\x; % Mean square solution
    z(indx_set(1:iter))   = z_T; % Update coding
    r   = x - atom_set(:,1:iter)*z_T; % Subtract current reconstruct. of x
    
    % Check Convergence
    converged = (iter>=smax) || (norm(r) < epsilon);
end

end
