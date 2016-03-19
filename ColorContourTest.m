fileName = '12003.jpg';
fig = imread(fileName);
ColorContour(fig);
% blueSize = size(blue);
% idx = kmeans(reshape(blue, [blueSize(1)*blueSize(2), 1]), 3);
% blueKMean = reshape(idx, blueSize);
% figure;rgb2hsv
% surf(blueKMean, fig,'edgecolor', 'none','FaceColor','texturemap')