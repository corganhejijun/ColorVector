clear; close all; clc;
img = imread('images/12003.jpg');
[height, width, channelCnt] = size(img);
%% Gmm divide
[idxMap, divideTree]= GmmBiDivide(img, false);
figure; imagesc(reshape(idxMap, height, width));
idxImg = reshape(idxMap, height, width);
segs = labelSeg(idxImg);
figure; imagesc(segs);
figure;imshow(img);