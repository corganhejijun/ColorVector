function HueCurveContour(filePath)
    fig = imread(filePath);
    hsvFig = rgb2hsv(fig); %转换为hsv图像更有利于分割
    hue = hsvFig(:,:,1);
    saturation = hsvFig(:,:,2);    %hue取值用不包含黑白色，饱和度和亮度用于分割黑白两种颜色
    % 当value小于0.2时，为黑色。当saturation小于0.1时，图像变为黑白
    value = hsvFig(:,:,3);
    [width, height] = size(hue);
    hueSort = reshape(hue, [1, width * height]);
    hueSort = sort(hueSort, 'descend');
    minSegPixCount = 0.05;  %分割区域占全部画面的最小百分比
    minHueDelta = 0.005;     %饱和度变化的最大范围，饱和度变化太大，则说明像素不属于同一个分区
    centers = HueCurveCenters(hueSort, minSegPixCount, minHueDelta);
    hueMap = zeros(size(hue, 1), size(hue, 2), size(centers, 2));
    for i = 1 : size(centers, 2)
        center = centers{i};
        radius = center(2);
        center = center(1);
        for j = 1 : size(hue, 2)
            for k = 1 : size(hue, 1)
                if hue(k, j) > center - radius && hue(k, j) < center + radius && value(k, j) > 0.2 && saturation(k, j) > 0.1
                    hueMap(k, j, i) = 1;
                end
            end
        end
        figure;
        surf(hueMap(:, :, i), fig,'edgecolor', 'none','FaceColor','texturemap')
    end
end