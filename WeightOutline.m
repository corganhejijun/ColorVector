function outlineWeight = WeightOutline(outlines)
    [height, width, channelNum] = size(outlines);
    radius = 1;
    outlineExt = zeros([height + 2 * radius, width + 2 * radius, channelNum]);
    outlineWeight = zeros([height + 2 * radius, width + 2 * radius, channelNum]);
    outlineExt(1+radius:height + radius, 1+radius:width + radius, :) = outlines;
    tic;
    for k = 1 : channelNum
        for i = 1+radius : height + radius
            for j = 1+radius : width + radius
                if outlineExt(i, j, k) == 0
                    continue;
                end
                if outlineWeight(i, j, k) > 0
                    %already set by other points of this line
                    continue;
                end
                lengthMat = TrackLine(outlineExt(:,:,k), i, j);
                outlineWeight(:,:,k) = outlineWeight(:,:,k) + lengthMat;
            end
        end
        outlineWeight(:,:,k) = outlineWeight(:,:,k) ./ max(max(outlineWeight(:,:,k)));
    end
    t = toc;
    fprintf('weight outline done: %1.2f sec\n', t);
    
    colorNames = {'white', 'red', 'green', 'blue', 'yellow', 'cyan', 'purple', 'black'};
    figure;
    for k = 1 : size(outlineWeight, 3)
        subplot(2, 4, k);
        imagesc(outlineWeight(:,:,k));
        title(colorNames(k));
    end

%     radius = ceil(max([height, width]) / 100);
%     expendOutline = zeros(height + 2*radius, width + 2*radius, channelNum);
%     expendOutline(radius + 1 : height + radius, radius + 1 : width + radius, :) = outlines;
%     tic;
%     for i = 1 : height
%         for j = 1 : width
%             if sum(outlines(i, j, :)) == 0
%                 continue;
%             end
%             subMat = expendOutline(i + radius : i + 2*radius, j + radius : j + 2*radius, :);
%             outlineWeight(i, j) = sum(subMat(:));
%         end
%     end
% 
%     t = toc;
%     fprintf('weight outline done: %1.2f sec\n', t);
end