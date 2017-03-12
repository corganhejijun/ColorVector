clear; close all; clc;
img = imread('images/42340051000005.jpg');
[height, width, channelCnt] = size(img);

compactness_factor = 20;
superpixel_number = 500;

%% superpixel: numlabels is the same as number of superpixels
[superPixel, numlabels] = slicmex(img, superpixel_number, compactness_factor);

%% get superpixel series
spList = cell(numlabels, 1);
for i = 1 : numlabels
    region = (superPixel == i);
    channel = img(:,:,1);
    subImg = [];
    subImg(:,1) = channel(region);
    channel = img(:,:,2);
    subImg(:,2) = channel(region);
    channel = img(:,:,3);
    subImg(:,3) = channel(region);
    spList{i} = subImg;
end

%%