%% 
clear; close all; clc;
fileName = '253027.jpg';
fig = imread(fileName);
colorDistance = ColorContour(fig);
[clusterResult, regions] = ClusterColorContour(colorDistance);
combineRegions = CombineRegions(regions);
%%
for i = 1 : size(combineRegions, 3)
    figure;imagesc(combineRegions(:,:,i));
end