
clear all; clc;
% load the example image
addpath(genpath('qtfm')); % add the qtfm library to the search path
tic;
for ii=41:41

   image_orig=imread(strcat('Original image\',[num2str(ii),'.bmp']));
   image_orig1=imread(strcat('Original image\',[num2str(ii+1),'.bmp']));

   if ndims(image_orig) == 3
        image_orig=rgb2gray(image_orig);    %对于灰度图不用添加，对于彩色图需要转换成灰度图
        image_orig1=rgb2gray(image_orig1);
   end

image = im2double(image_orig); % @note: you can of course at this point also convert into another color space, e.g. Lab, YUV or ICOPP
image1=im2double(image_orig1);


[m n]=size(image);
use_colormap = false;                                % @note: I advise the use of colormaps, because they make it much easier to see the differences than grey scale maps
     
% like to see 
algorithms = {'quat:dct'};    %@note: specify the names of the algorithms whose saliency maps you would
% algorithms = {'quat:fft:pqft'}; 

saliency_map_resolution = [m n];                  % the target saliency map resolution; the most important parameter for spectral saliency approaches
smap_smoothing_filter_params = {'gaussian',5,1.5};  % filter parameters for the final saliency map
cmap_smoothing_filter_params = {};                  % optionally, you can also smooth the conspicuity maps
cmap_normalization = 1;                             % specify the normalization of the conspicuity map here
extended_parameters = {};                           % @note: here you can specify advanced algorithm parameters for the selected algorithm, e.g. the quaternion axis
do_figures = false;                                 % enable/disable spectral_saliency_multichannel's integrated visualizations

subplot_grid={1,numel(algorithms)+1};

% calculate the saliency map
saliency_map = spectral_saliency_multichannel(image,image1,saliency_map_resolution,algorithms{1},smap_smoothing_filter_params,cmap_smoothing_filter_params,cmap_normalization,extended_parameters,do_figures);

saliency_map=mat2gray(saliency_map);
figure;
imshow(saliency_map,[]);
imwrite(saliency_map,'42.bmp')
end   
toc;
warning off;    


