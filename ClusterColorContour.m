function [clusterResult, outline] = ClusterColorContour(contour)
% 将传入的Color Contour分类，每一种颜色都分为前景和背景两类    
    tic;
    clusterResult = zeros(size(contour));
    % outline will be double
    outline = zeros(size(contour, 1), size(contour, 2), size(contour, 3));
%     colorThreshold = 0.1;
    for k = 1 : size(contour, 3)
        oneContour = contour(:,:,k);
        [height, width] = size(oneContour);
        oneContour = reshape(oneContour, [width*height, 1]);
        % 图片分为2类
        result = kmeans(oneContour, 2);
        result = reshape(result, [height, width]);
%         result = (contour(:,:,k) > colorThreshold);
%         result = imfill(result, 'holes');
        clusterResult(:,:,k) = result;
        % make the smaller region be the object, usually the bigger region
        % is background
        result1 = (result == 1);
        result1 = bwmorph(result1, 'clean');
        result1 = bwmorph(result1, 'remove');
        result1 = bwmorph(result1, 'clean');
        result2 = (result == 2);
        result2 = bwmorph(result2, 'clean');
        result2 = bwmorph(result2, 'remove');
        result2 = bwmorph(result2, 'clean');
        outline(:,:,k) = or(result1, result2);
    end
    t = toc;
    fprintf('cluster color contour done: %1.2f sec\n', t);
    
    colorNames = {'white', 'red', 'green', 'blue', 'yellow', 'cyan', 'purple', 'black'};
    figure;
    for k = 1 : size(contour, 3)
        handle = subplot(2, 4, k);
        CreateClusterFigure(clusterResult(:,:,k), handle);
        title(colorNames(k));
    end
%     figure;
%     for k = 1 : size(contour, 3)
%         subplot(2, 4, k);
%         imagesc(outline(:,:,k));
%         title(colorNames(k));
%     end
end