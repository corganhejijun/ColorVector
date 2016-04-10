function [ combine ] = CombineColorSection( weightOutline )
%combine regions defined by weight outline

    [height, width, channelCnt] = size(weightOutline);
    % dismiss regions smaller than threshold
    regionThreshold = ceil((height * width) / 100); 
    combine = zeros(height, width);
    for i = 1 : channelCnt
        channel = weightOutline(:,:,i);
        fillColor = imfill(channel);
        labelRegin = bwlabel(fillColor);
        [label, labelCnt] = histcounts(labelRegin);
        regionslabel = [];
        % dismiss small regions
        for j = 1 : size(label)
            if labelCnt > regionThreshold
                if length(regionslabel) == 0
                    regionslabel(1) = label;
                else
                    regionslabel(length(regionslabel)) = label;
                end
            end
        end
        % get regions list for one color channel
        regions = [];
        for j = 1 : length(regionslabel)
            regions(j) = (labelRegin == regionslabel(j));
        end
        % combine regions from different channels
    end

end

