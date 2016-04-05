function [clusterResult, outline] = ClusterColorContour(contour)
% �������Color Contour���࣬ÿһ����ɫ����Ϊǰ���ͱ�������
    colorNames = {'white', 'red', 'green', 'blue', 'yellow', 'cyan', 'purple', 'black'};
    
    tic;
    clusterResult = zeros(size(contour));
    outline = zeros(size(contour));
    for k = 1 : size(contour, 3)
        oneContour = contour(:,:,k);
        [height, width] = size(oneContour);
        oneContour = reshape(oneContour, [width*height, 1]);
        % ͼƬ��Ϊ2��
        result = kmeans(oneContour, 2);
        result = reshape(result, [height, width]);
        result = imfill(result, 'holes');
        clusterResult(:,:,k) = result;
        result = result - 1;
        result = bwmorph(result, 'remove');
        result = bwmorph(result, 'clean');
        outline(:,:,k) = result;
    end
    t = toc;
    fprintf('cluster color contour done: %1.2f sec\n', t);
    
    figure;
    for k = 1 : size(contour, 3)
        handle = subplot(2, 4, k);
        CreateClusterFigure(clusterResult(:,:,k), handle);
        title(colorNames(k));
    end
    figure;
    for k = 1 : size(contour, 3)
        subplot(2, 4, k);
        imagesc(outline(:,:,k));
        title(colorNames(k));
    end
end