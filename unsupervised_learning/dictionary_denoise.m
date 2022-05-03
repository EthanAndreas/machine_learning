function [im_out,natoms] = dictionary_denoise(im_in,dict,...
                                             blocksize,stride,epsilon,smax)
%%%%%%%%%%%%%%%%% Dictionary-Based Image Denoising %%%%%%%%%%%%%%%%%%%%%%%%
% Denoises the image im_in using dictionary dict with block size blocksize
% using a sparse coding method.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% INPUT %%%%%%
% - im_in (sizex*sizey) : input image
% - dict (N*K) : input dictionary with K N-dimensional atoms
% - blocksize [int,int] : size of image patches used ( prod(blocksize)=N )
% - stride = [int,int] : stride used in x and y directions
% - epsilon (double) : target reconstruction error
% - smax (int) : target maximum sparsity
%%%%%% OUTPUT %%%%%
% - im_out (sizex*sizey) : denoised image
% - natoms (sizex*sizey) : number of atoms used per pixel
%
%%%%%% TP Telecom Physique Strasbourg 2021
%%%%%% Antoine Deleforge (antoine.deleforge@inria.fr)
%%%%%% Code inspired from the implementation of Ron Rubinstein (2009)
%%%%%  References:
%  [1] M. Elad and M. Aharon, "Image Denoising via Sparse and Redundant
%      representations over Learned Dictionaries", the IEEE Trans. on Image
%      Processing, Vol. 15, no. 12, pp. 3736-3745, December 2006.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('Dictionary Denoising...');
p = 2; % the image is 2-dimensional

im_out = zeros(size(im_in)); % Output image
natoms = zeros(size(im_in)); % Output number of atoms used

% ids{} contains the indices of the current block
ids = cell(p,1);
for j = 1:p
  ids{j} = 1:blocksize(j);
end

% lastids contains the indices of the last block in each dimension
lastids = stride .* floor((size(im_in)-blocksize)./stride) + 1;

blocknum = prod(floor((size(im_in)-blocksize)./stride) + 1);

%Main Loop
for i = 1 : blocknum
  block = im_in(ids{:});
  block = block(:);
  dc = mean(block);
  block = block-dc;
  
  % Sparse coding
  x = sparse_coding(dict,block,epsilon,smax);

  % Save number of atoms used
  natoms(ids{:}) = sum(x~=0);
  
  % Add atoms to the denoised image
  im_out(ids{:}) = im_out(ids{:}) + reshape(dict*x,blocksize) + dc;

  % increment block ids
  if (i<blocknum)
    j = 1;
    while (ids{j}(1) == lastids(j))
      ids{j} = 1:blocksize(j);
      j = j+1;
    end
    ids{j} = ids{j}+stride(j);
  end
  
  % Display iterations
  if(mod(i,10000)==0)
    fprintf(1,'Block nr %d / %d processed\n',i,blocknum);
  end
end

% Avoid border effects
cnt = countcover(size(im_in),blocksize,stride);
im_out = im_out./cnt;
im_out = reshape(im_out,size(im_in));

natoms = reshape(natoms,size(im_in));

end
