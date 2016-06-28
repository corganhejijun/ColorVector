%%
clear; close all; clc;
%a = imread('images/test/100099.jpg');
a = imread('12003.jpg');
[height, width, channelCnt] = size(a);

%%
[idxMap, divideTree]= GmmBiDivide(a, true);

%%
close all;
maxIdx = max(idxMap);
imgList = reshape(a, height*width, channelCnt);
segList = cell(maxIdx, 1);
for i = 1 : maxIdx
    if sum(idxMap==i) == 0
        continue
    end
    segImg = zeros(height*width, channelCnt);
    segImg(idxMap==i, :) = imgList(idxMap==i, :);
    segImg = reshape(segImg, height, width, channelCnt);
    figure; imagesc(segImg./255);
    segList{i} = segImg;
end
%%
segs = {};
segs{1} = labelSeg(reshape(idxMap, height, width));
figure; imagesc(segs{1});
figure; imagesc(segs{1} == 1);

%%
a = imresize(a,[64 NaN]);
[height, width, channelCnt] = size(a);
scatterColor = reshape(a, height*width, channelCnt);
scatterColor = double(scatterColor)/255;
vec = reshape(rgb2lab(a), height*width, channelCnt);
%%
% [idx, C] = kmeans(vec, 2);

%%
options = statset('MaxIter',500);
gmm = fitgmdist(vec,2,'Options',options);
gmmIdx = cluster(gmm, vec);
%%
scatter3(vec(:,1), vec(:,2), vec(:, 3), (gmmIdx-1)*20+5, scatterColor, 'filled', 'MarkerEdgeColor','k');

%%
vec1 = vec;
vec1(gmmIdx~=1,:) = [];
vec2 = vec;
vec2(gmmIdx~=2,:) = [];
%%
result1 = zeros(height*width, channelCnt);
result2 = zeros(height*width, channelCnt);
imgList = reshape(a, height*width, channelCnt);
result1(gmmIdx==1,:) = imgList(gmmIdx==1,:);
result2(gmmIdx==2,:) = imgList(gmmIdx==2,:);
result1 = reshape(result1, height, width, channelCnt);
result1 = result1/255;
result2 = reshape(result2, height, width, channelCnt);
result2 = result2/255;
figure; imagesc(result1);
figure; imagesc(result2);