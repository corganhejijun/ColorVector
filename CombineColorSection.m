function [ combine ] = CombineColorSection( weightOutline )
%combine regions defined by weight outline

    [height, width, channelCnt] = size(weightOutline);
    % dismiss regions smaller than threshold
    regionThreshold = ceil((height * width) / 100);
    intersectionThreshold = regionThreshold;
    combineCells = {};
    for i = 1 : channelCnt
        channel = weightOutline(:,:,i);
        fillColor = imfill(channel);
        [labelRegin, labelCnt] = bwlabel(fillColor);
        % The value X(i) is in the kth bin if edges(k) ¡Ü X(i) < edges(k+1). 
        % The last bin also includes the right bin edge
        [labelCnt, label] = histcounts(labelRegin, 1:labelCnt+1);
        regionslabel = [label(1:end-1); labelCnt];
        % dismiss small regions
        [~, unDissmissCol] = find(regionslabel(2,:) > regionThreshold);
        regionslabel = regionslabel(:, unDissmissCol);
        % get regions list for one color channel
        regions = cell(size(regionslabel, 2), 1);
        for j = 1 : size(regionslabel, 2)
            regions{j} = (labelRegin == regionslabel(1, j));
        end

        % combine regions from different channels
        for j = 1 : length(regions)
            found = false;
            for k = 1 : length(combineCells)
                if and(combineCells{k}, regions{j}) == regions{j}
                    % region contain another, escape
                    found = true;
                    break;
                elseif and(combineCells{k}, regions{j}) == combineCells{k}
                    % region is contained, update
                    combineCells{k} = regions{j};
                    found = true;
                    break;
                else
                    % region intersect with small differences, combine two
                    % regions
                    regionDiff = xor(combineCells{k}, regions{j});
                    diff1 = and(combineCells{k}, regionDiff);
                    diff2 = and(regions{j}, regionDiff);
                    sum1 = sum(diff1(:));
                    sum2 = sum(diff2(:));
                    if sum2 < sum1
                        regionDiff = sum2;
                    else
                        regionDiff = sum1;
                    end
                    if regionDiff < intersectionThreshold
                        combineCells{k} = or(combineCells{k}, regions{j});
                        found = true;
                        break;
                    end
                end
            end
            if isempty(combineCells)
                combineCells{1} = regions{j};
            elseif ~found
                combineCells{length(combineCells) + 1} = regions{j};
            end
        end
    end

    combine = combineCells;
end

