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
    
%% 显示color vector 计算结果
    colorNames = {'white', 'red', 'green', 'blue', 'yellow', 'cyan', 'purple', 'black'};
    figure;
    for i = 1 : basicColorType
        %figure;
        %surf(colorDistMat(:, :, i), fig, 'edgecolor', 'none', 'FaceColor', 'texturemap');
        oneMat = colorDistMat(:, :, i);
        colorDistMat(:, :, i) = oneMat ./ max(oneMat(:));
        handle = subplot(2, 4, i);
        CreateColorContourFigure(colorDistMat(:, :, i), fig, handle);
        title(colorNames(i));
    end
    
%% 计算每个像素是边缘像素的概率
% 1 0 1 计算对角方向的四个像素与中心像素的距离差值，取最大者为该像素与边缘的距离，
% 0 1 0 除以maxColorVectorDistance作为边缘概率
% 1 0 1  
% threshold为边缘阈值，a、b分别为小于和大于threshold时边缘概率的下降速率，边缘概率曲线表示为
%   if x < threshold : prob = ax;
%   if x > threshold : prob = bx;
%   and prob 不小于1 且 不大于0
%     threshold = 0.25;
%     a = 4;
%     b = -4;
%     vecDistRadius = floor(max(size(fig)) / 100);
%     colorVectorContourProb = zeros(size(colorDistMat));
%     for i = vecDistRadius + 1 : size(fig, 1) - vecDistRadius
%         for j = vecDistRadius + 1 : size(fig, 2) - vecDistRadius
%             for k = 1 : basicColorType
%                 upLeft = norm(colorDistMat(i, j, k) - colorDistMat(i - vecDistRadius, j - vecDistRadius, k));
%                 upRight = norm(colorDistMat(i, j, k) - colorDistMat(i - vecDistRadius, j + vecDistRadius, k));
%                 downLeft = norm(colorDistMat(i, j, k) - colorDistMat(i + vecDistRadius, j - vecDistRadius, k));
%                 downRight = norm(colorDistMat(i, j, k) - colorDistMat(i + vecDistRadius, j + vecDistRadius, k));
%                 maxVecDist = max([upLeft, upRight, downLeft, downRight]);
%                 prob = colorDistMat(i, j, k);
%                 if prob > threshold
%                     prob = prob * b + 1;
%                 elseif prob <= threshold
%                     prob = prob * a;
%                 end
%                 if prob < 0
%                     prob = 0;
%                 end
%                 colorVectorContourProb(i, j, k) = prob * maxVecDist;
%             end
%         end
%     end
end