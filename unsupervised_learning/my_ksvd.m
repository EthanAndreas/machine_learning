function [D,X] = my_ksvd(Y,initdict,epsilon,smax,maxiter)
%%%%%%%%%%%%%%%%%%%%% K-SVD dictionary learning %%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Runs the K-SVD dictionary learningalgorithm on the specified set of
%  signals Y, returning the trained dictionary D and the sparse coding X
%  such that Y ~ D*X.
%
%  More precisely, we intend to solve:
%
%      min  |Y-D*X|_F^2    s.t. for all i : |X_i|_0 <= smax 
%      D,X                             or : |Y_i - D*X_i|_2 <= epsilon
%
%  where Y is the set of training signals, X_i is the i-th column of
%  X, smax is the target sparsity and thresh is the target error.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% INPUT %%%%%%
% - Y (N x T) : Set of T N-dimensional training signals
% - initdict (N x K) : Initial N-dimensional dictionary with K atoms
% - epsilon (double) : Target reconstruction error per signal
% - smax (int) : Maximum number of nonzero element in columns of X
% - maxiter (int) : Maximum number of iterations
%
%%%%%% OUTPUT %%%%%
% - D (N x K) : Output N-dimensional dictionary with K atoms
% - X (K x T) : Output sparse coding
%
%%%%%% TP Telecom Strasbourg 2021
%%%%%% Antoine Deleforge (antoine.deleforge@inria.fr)
%%%%%% Code inspired from the implementation of Ron Rubinstein (2009)
%%%%%  References:
%  [1] M. Aharon, M. Elad, and A.M. Bruckstein, "The K-SVD: An Algorithm
%      for Designing of Overcomplete Dictionaries for Sparse
%      Representation", the IEEE Trans. On Signal Processing, Vol. 54, no.
%      11, pp. 4311-4322, November 2006.
%  [2] M. Elad, R. Rubinstein, and M. Zibulevsky, "Efficient Implementation
%      of the K-SVD Algorithm using Batch Orthogonal Matching Pursuit",
%      Technical Report - CS, Technion, April 2008.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%  Initialize variables  %%%%%%%%%%%%%%%%%
% Initialize D with initdict and normalize its columns to unit norm
%   Tip: use normcols

%       TODO

% Initialize X by a zero matrix of size K x T

%       TODO

%%%%%%%%%%%%%%%%%  main loop  %%%%%%%%%%%%%%%%%
for iter=1:maxiter
    %%%%%  sparse coding  %%%%%
    % For t = 1...T, sparsely code the signal Y(:,t) using dictionary D and
    % place the code in X(:,t)

    %       TODO

    %%%%%  dictionary update  %%%%%
    % For k = 1...K, update the atom d_k = D(:,k)
    for k = 1:K

        % Compute idx, the set of signal indices in {1,...,T} that use
        % atom d_k.      Tip: use "find"
        
        %       TODO 

        % Case of unused Atom (idx is empty)
        %    - Easy option : Ignore it
        %    - Advanced option : Replace d_k by the most poorly 
        %                        reconstructed signal
        if isempty(idx)
            
        else
            % Compute Xbis and Ybis the submatrix of X and Y corresponding
            % to signals of indices idx
            
            %       TODO

            % Extract x_k, the row vector containing the nonzero weights 
            % that these signals give to atom d_k
            
            %       TODO

            % Compute R, the current residual when reconstructing Ybis
            % *without* using d_k and x_k.
            %       TODO

            % update x_k and d_k such that d_k*x_k is the best rank-1
            % approximation of R. Tip: use "svds"
            
            %       TODO
            
            % Update X and D with the new x_k and d_k
            
            %       TODO
            
        end
    end

    %%%%% Print current iteration %%%%%
    fprintf(1,'Iteration %d / %d complete\n',iter,maxiter);

    %%%%% Compute and print ||Y - DX||^2_2 / ||Y||_2^2, the relative mean
    %%%%% squared error (RMSE) on this iteration
    
    %     TODO (optional)

    %%%%% Early stopping when the RMSE is less than 0.1 %
    
    %     TODO (optional)
  
end

end



