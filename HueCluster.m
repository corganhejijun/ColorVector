function [ centers ] = HueCluster( img )
%Get hue centers of image
    [height, width, ~] = size(img);
    hsvImg = rgb2hsv(img);
    % 当value小于0.2时，为黑色。当saturation小于0.1时，图像变为黑白
    blackValueThreshold = 0.2;
    colorSaturationThreshold = 0.1;
    clusterAICChangeThreshold = 0.21;
    hue = hsvImg(:,:,1);
    saturation = hsvImg(:,:,2);
    grayMap = (saturation < colorSaturationThreshold);
    value = hsvImg(:,:,3);
    
    blackMap = (value < blackValueThreshold);
    colorMap = ~or(grayMap, blackMap);
    % delete black in gray map, only gray and white
%     grayMap = xor(grayMap, and(grayMap, blackMap));
    
    hue = hue .* colorMap;
    % black is -0.2, white and gray is -0.1
    hue = hue - (~colorMap)*0.1 - blackMap*0.1;
    hueData = reshape(hue, [1, height*width]);
    lastGmm = {};
    lastDelta = 0;
    options = statset('MaxIter',500);
    for i = 1 : 10
        gmm = fitgmdist(hueData', i, 'Options',options);
        disp([num2str(i), ' AIC = ', num2str(gmm.AIC)]);
        if ~isempty(lastGmm)
            disp(['last delta = ', num2str(lastDelta)]);
            if lastGmm.AIC < gmm.AIC || (lastGmm.AIC - gmm.AIC) < clusterAICChangeThreshold*lastDelta
                break;
            end
            lastDelta = lastGmm.AIC - gmm.AIC;
        end
        lastGmm = gmm;
    end
    disp('cluster result is:');
    disp(lastGmm);
    meanSaturation = mean(saturation(:));
    meanValue = mean(value(:));
    centers = zeros([size(lastGmm.mu, 1), 3]);
    for i = 1 : size(lastGmm.mu, 1)
        if (lastGmm.mu(i) < 0)
            centers(i, :) = [0, 0, 10*(lastGmm.mu(i) + 0.2)];
        else
            centers(i, :) = [lastGmm.mu(i), meanSaturation, meanValue];
        end
    end
    centers = hsv2rgb(centers);
    
    [numbers, edges] = histcounts(hueData);
    figure;
    for b = 1 : size(numbers, 2)
        % Plot one single bar as a separate bar series.
        handleToThisBarSeries(b) = bar(edges(b), numbers(b), 'BarWidth', (edges(b+1) - edges(b)));
        % Apply the color to this bar series.
        if edges(b) < 0
            if edges(b) == -2
                faceColor = [0 0 0];
            elseif edges(b) == -1
                faceColor = [1 1 1];
            else
                faceColor = [0.5 0.5 0.5];
            end
        else
            faceColor = hsv2rgb([edges(b), 0.7, 0.7]);
        end
        set(handleToThisBarSeries(b), 'FaceColor', faceColor);
        hold on;
    end
    hold off;
    xlim([min(edges), max(edges)]);
    title('hue');
    figure;histogram(reshape(saturation, [1, height*width]));
    title('saturation');
    figure;histogram(reshape(value, [1, height*width]));
    title('value');
end

