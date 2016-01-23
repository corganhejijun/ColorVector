function colorContour = ColorContour(filePath)
    fig = imread(filePath);
    colorContour = zeros(size(fig(:,:,1)));
    %colorContour2 = zeros(size(fig(:,:,1)));
    blue    = [0, 0, 255];
    %red     = [255, 0, 0];
    for i = 1 : size(fig, 1)
        for j = 1 : size(fig, 2)
            if ColorDistance(double(reshape(fig(i, j, :), [1, 3])), blue) > 1
                colorContour(i, j) = 1;
            else
                colorContour(i, j) = 0;
            end
            %colorContour2(i, j) = ColorDistance(double(reshape(fig(i, j, :), [1, 3])), red);
        end
    end
    figure;
    surf(colorContour, fig,'edgecolor', 'none','FaceColor','texturemap')
%     figure;
%     surf(colorContour2, fig,'edgecolor', 'none','FaceColor','texturemap')
end