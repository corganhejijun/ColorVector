%======================================================================
%SLIC demo
% Copyright (C) 2015 Ecole Polytechnique Federale de Lausanne
% File created by Radhakrishna Achanta
% Please also read the copyright notice in the file slicmex.c 
%======================================================================
%Input parameters are:
%[1] 8 bit images (color or grayscale)
%[2] Number of required superpixels (optional, default is 200)
%[3] Compactness factor (optional, default is 10)
%
%Ouputs are:
%[1] labels (in raster scan order)
%[2] number of labels in the image (same as the number of returned
%superpixels
%
%NOTES:
%[1] number of returned superpixels may be different from the input
%number of superpixels.
%[2] you must compile the C file using mex slicmex.c before using the code
%below
%======================================================================
%img = imread('someimage.jpg');
clear; close all;
img = imread('12003.jpg');
[labels, numlabels] = slicmex(img,500,20);%numlabels is the same as number of superpixels
region_borders = imdilate(labels,ones(3,3)) > imerode(labels,ones(3,3));
figure;
imagesc(img);
figure;
imagesc(img);
hold on;
mask = ones(size(img));
mask(:,:,1) = mask(:,:,1)*0.3;
mask(:,:,2) = mask(:,:,2)*1;
mask(:,:,3) = mask(:,:,3)*0.136;
h = imagesc(mask);
set(h, 'AlphaData', region_borders);
hold off;
avgImg = zeros(size(img));
img = im2double(img);
for i = 0 : (numlabels-1)
    label = double(labels == i);
    avg(1) = sum(img(:,:,1).*label)/sum(label);
    avg(2) = sum(img(:,:,2).*label)/sum(label);
    avg(3) = sum(img(:,:,3).*label)/sum(label);
    avgImg(:,:,1) = avgImg(:,:,1) + label * avg(1);
    avgImg(:,:,2) = avgImg(:,:,2) + label * avg(2);
    avgImg(:,:,3) = avgImg(:,:,3) + label * avg(3);
end
figure;
imagesc(avgImg);

