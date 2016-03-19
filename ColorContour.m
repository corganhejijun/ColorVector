function colorDistMat = ColorContour(fig)
% 求图像中每个点的颜色距离
%%
% 基本颜色有8种, white, red, green, blue, yellow, cyan, purple, black.
% 具体值详见ColorVector注释.
% TODO: 通过聚类方法自动获取图片中的主要颜色种类
    basicColorType = 8;
    colorDistMat = zeros([size(fig(:,:,1)), basicColorType]);
    for i = 1 : size(fig, 1)
        for j = 1 : size(fig, 2)
            colorDistMat(i, j, :) = ColorVector(reshape(double(fig(i, j, :)), [1, 3]));
        end
    end
    
    colorNames = {'white', 'red', 'green', 'blue', 'yellow', 'cyan', 'purple', 'black'};
    for i = 1 : basicColorType
        figure;
        surf(colorDistMat(:, :, i), fig, 'edgecolor', 'none', 'FaceColor', 'texturemap');
        title(colorNames(i));
    end
end