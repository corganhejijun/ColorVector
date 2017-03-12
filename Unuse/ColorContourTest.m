%% 
clear; close all; clc;
fileName = '253027.jpg';
fig = imread(fileName);
%%
DivideCluster(fig);

%%
ColorDistmap(fig);

%% 通过聚类方法自动获取图片中的主要颜色种类
[height, width, ~] = size(fig);
% resize image short edge to 100px
smallFig = imresize(fig, 100/min([height, width]));
hueCenters = HueCluster(smallFig);
hueCenters = hueCenters .* 255;

%% show cneter colors
centerColors = zeros([100 * size(hueCenters, 1), 100, 3]);
for i = 1 : 100
    for j = 1 : 100
        for k = 1 : size(hueCenters, 1)
            centerColors(100*(k-1)+i, j, :) = hueCenters(k, :);
        end
    end
end
figure; imagesc(uint8(centerColors));
% centers = GmmCluster(smallFig, 8, true);

%%
colorDistance = ColorContour(smallFig, hueCenters);
[clusterResult, regions] = ClusterColorContour(colorDistance);
[combineRegions, regionList] = CombineRegions(regions);
combineRegionList = CombineSameColorRegions(smallFig, regionList);
%%
allRegion = zeros(size(combineRegions, 1), size(combineRegions, 2));
for i = 1 : size(combineRegions, 3)
    figure;imagesc(combineRegions(:,:,i));
    allRegion = allRegion + combineRegions(:,:,i);
end
figure; imagesc(allRegion);

%% show matrix array
close all;
for i = 1 : size(colorDistance, 3)
    figure; surf(colorDistance(:,:,i));
end

%% show cell array
close all;
for i = 1 : length(regionList)
    figure; imagesc(regionList{i});
end