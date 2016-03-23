function clusterResult = ClusterColorContour(contour)
% �������Color Contour���࣬ÿһ����ɫ����Ϊǰ���ͱ�������
    colorNames = {'white', 'red', 'green', 'blue', 'yellow', 'cyan', 'purple', 'black'};
    clusterResult = zeros(size(contour));
    figure;
    for k = 1 : size(contour, 3)
        oneContour = contour(:,:,k);
        [height, width] = size(oneContour);
        oneContour = reshape(oneContour, [width*height, 1]);
        % ͼƬ��Ϊ2��
        result = kmeans(oneContour, 2);
        clusterResult(:,:,k) = reshape(result, [height, width]);
        handle = subplot(2, 4, k);
        CreateClusterFigure(clusterResult(:,:,k), handle);
        title(colorNames(k));
    end
end