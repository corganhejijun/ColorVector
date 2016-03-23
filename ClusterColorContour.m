function clusterResult = ClusterColorContour(contour)
% 将传入的Color Contour分类，每一种颜色都分为前景和背景两类
    colorNames = {'white', 'red', 'green', 'blue', 'yellow', 'cyan', 'purple', 'black'};
    clusterResult = zeros(size(contour));
    figure;
    for k = 1 : size(contour, 3)
        oneContour = contour(:,:,k);
        [height, width] = size(oneContour);
        oneContour = reshape(oneContour, [width*height, 1]);
        % 图片分为2类
        result = kmeans(oneContour, 2);
        clusterResult(:,:,k) = reshape(result, [height, width]);
        handle = subplot(2, 4, k);
        CreateClusterFigure(clusterResult(:,:,k), handle);
        title(colorNames(k));
    end
end