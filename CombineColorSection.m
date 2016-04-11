function [ combine ] = CombineColorSection( weightOutline )
%combine regions defined by weight outline

    [height, width, channelCnt] = size(weightOutline);
    % dismiss regions smaller than threshold
    regionThreshold = ceil((height * width) / 100); 
    combine = zeros(height, width);
    combineCells = cell(channelCnt);
    for i = 1 : channelCnt
        channel = weightOutline(:,:,i);
        fillColor = imfill(channel);
        labelRegin = bwlabel(fillColor);
        [label, labelCnt] = histcounts(labelRegin);
        regionslabel = [label; labelCnt];
        % dismiss small regions
        [~, unDissmissCol] = find(regionslabel(2,:) > regionThreshold);
        regionslabel = regionslabel(:, unDissmissCol);
        % get regions list for one color channel
        regions = [];
        for j = 1 : length(regionslabel)
            regions(j) = (labelRegin == regionslabel(j));
        end
        combineCells(i) = regions;
    end

    seprateRegion = {};
    % combine regions from different channels
    for i = 1 : length(combineCells)
        for j = 1 : length(combineCells{i})
            for k = 1 : length(seprateRegion)
                if seprateRegion{k} && combineCells{i}(j) == seprateRegion{k}
                    % region is contained, update
                    seprateRegion{k} = combineCells{i}{j};
                    break;
                elseif seprateRegion{k} && combineCells{i}(j) == combineCells{i}(j)
                    % region contain another, escape
                    break;
                end
            end
        end
    end
    combine = seprateRegion;
end

