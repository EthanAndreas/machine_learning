function Y = im2blocks(img,numblocks,blocksize)
%%%%%%%%%%%%%%% Create Training data from image patches %%%%%%%%%%%%%%%%%%%
p = numel(blocksize); % = 2 for images

%%%% create training data %%%
ids = cell(p,1);
[ids{:}] = reggrid(size(img)-blocksize+1, numblocks, 'eqdist');
Y = sampgrid(img,blocksize,ids{:});
Y = remove_dc(Y,'columns');

end