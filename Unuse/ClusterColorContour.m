function [clusterResult, regions] = ClusterColorContour(contour)
% 将传入的Color Contour分类，每一种颜色都分为前景和背景两类    
    tic;
    clusterResult = zeros(size(contour));
    [height, width, channelCnt] = size(contour);
    % delete small regions
    regionThreshold = ceil(height*width/1000);
    % one channel data is clustered into 2, so regions will be double
    regions = zeros(height, width, channelCnt * 2);
    for k = 1 : channelCnt
        oneContour = contour(:,:,k);
        [height, width] = size(oneContour);
        oneContour = reshape(oneContour, [width*height, 1]);
        % 图片分为2类
        result = kmeans(oneContour, 2);
        result = reshape(result, [height, width]);
        clusterResult(:,:,k) = result;
        % make the smaller region be the object, usually the bigger region
        % is background
        result1 = (result == 1);
        result1 = ~result1;
        result1 = bwareaopen(result1, regionThreshold);
        result1 = ~result1;
        result1 = bwareaopen(result1, regionThreshold);
        result2 = (result == 2);
        result2 = ~result2;
        result2 = bwareaopen(result2, regionThreshold);
        result2 = ~result2;
        result2 = bwareaopen(result2, regionThreshold);
        regions(:,:,2*k-1) = bwlabel(result1);
        regions(:,:,2*k) = bwlabel(result2);
    end
    t = toc;
    fprintf('cluster color contour done: %1.2f sec\n', t);
    
    figure;
    for k = 1 : channelCnt
        handle = subplot(2, 4, k);
        CreateClusterFigure(clusterResult(:,:,k), handle);
    end
end