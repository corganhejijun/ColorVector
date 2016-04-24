%% 
clear; close all; clc;
fileName = '2.jpg';
fig = imread(fileName);
%% ͨ�����෽���Զ���ȡͼƬ�е���Ҫ��ɫ����
[height, width, ~] = size(fig);
% resize image short edge to 100px
smallFig = imresize(fig, 100/min([height, width]));
centers = GmmCluster(smallFig, 8);

%%
colorDistance = ColorContour(fig, centers);
[clusterResult, regions] = ClusterColorContour(colorDistance);
combineRegions = CombineRegions(regions);
%%
allRegion = zeros(height, width);
for i = 1 : size(combineRegions, 3)
    figure;imagesc(combineRegions(:,:,i));
    allRegion = allRegion + combineRegions(:,:,i);
end
figure; imagesc(allRegion);

%%
close all;
for i = 1 : size(regions, 3)
    figure; imagesc(regions(:,:,i));
end