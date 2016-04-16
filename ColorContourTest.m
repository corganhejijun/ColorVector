%% 
clear; close all; clc;
fileName = '12003.jpg';
fig = imread(fileName);
colorDistance = ColorContour(fig);
[clusterResult, regions] = ClusterColorContour(colorDistance);

% for i = 1 : size(weightOutline, 3)
%     figure;imagesc(weightOutline(:,:,i));
% end