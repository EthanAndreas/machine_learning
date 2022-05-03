%%%%% TP Dictionary Learning TPS - main Script %%%%%
%%%%% Antoine Deleforge (antoine.deleforge@inria.fr)

addpath('tools/');

%% Load Image:
imgname = 'images /boat.png';

%% Generate noisy image
disp(' ');
disp('Generating noisy image...');

im = imread(imgname);
maxval = double(max(im(:))); % Maximal intensity value of loaded image
im = double(im); % Convert to double

sigma = 20; % Noise Level

noise = randn(size(im)) * sigma;
imnoise = im + noise;

%% Generate a 2-dimensional ODCT dictionary
blocksize = [8,8]; % Size of patches
dictsize = 256; % Size of dictionary
dict = odctndict(blocksize,dictsize,2);

%% Denoise image using dictionary
stride = blocksize;
epsilon = sqrt(prod(blocksize)) * sigma * sqrt(2); 
smax = round(dictsize/2);
[im_out, natoms] = dictionary_denoise(imnoise,dict,blocksize,stride,...
                                      epsilon,smax);

%% Show results

% Show original image
fig=figure; clf(fig);
movegui('northwest');
imagesc(im);
colormap('Gray');
title('Original image');

% Show noisy image and compute PSNR
fig=figure; clf(fig);
movegui('north');
imagesc(imnoise); 
colormap('Gray');
title(sprintf('Noisy image, PSNR = %.2fdB',...
      20*log10(maxval * sqrt(numel(im)) / norm(im(:)-imnoise(:))) ));

% Show number of atoms used
fig=figure; clf(fig);
movegui('northeast');
imagesc(natoms);
colorbar;
title('Number of ODCT atoms used');

% Show dictionary
dictimg = showdict(dict,blocksize,round(sqrt(dictsize)),...
                   round(sqrt(dictsize)),'lines','highcontrast');
fig=figure; clf(fig);
movegui('northeast');
imagesc(dictimg);
colormap('Gray');
title('ODCT Dictionary');

% Show cleaned image with ODCT and compute PSNR
fig=figure; clf(fig);
movegui('southwest');
imagesc(im_out/maxval);
colormap('Gray');
title(sprintf('Denoised image ODCT, PSNR: %.2fdB',...
      20*log10(maxval * sqrt(numel(im)) / norm(im(:)-im_out(:))) ));
