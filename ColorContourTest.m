%% 
clear; close all; clc;
fileName = '12003.jpg';
fig = imread(fileName);
colorDistance = ColorContour(fig);
[clusterResult, regions] = ClusterColorContour(colorDistance);
combineRegions = CombineRegions(regions);
%%
for i = 1 : size(regions, 3)
    figure;imagesc(regions(:,:,i));
end