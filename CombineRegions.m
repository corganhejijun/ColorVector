function [ result ] = CombineRegions( regions )
% combine regions into one figure
%   Detailed explanation goes here
    [height, width, channelCnt] = size(regions);
    diffThreshold = height*width/1000;
    backgroundHoleThres = height*width/100;
    regionList = {};
    regionSizeList = [];
    for i = 1 : channelCnt
        region = regions(i);

        % regions in one channel is labeled
        regionNo = max(region(:));
        for j = 1 : regionNo
            region1 = (region == j);

            % if region contain large holes, it would be background region
            regionFill = imfill(region1);
            holeDiff = xor(region1, regionFill);
            if (sum(holeDiff(:)) > backgroundHoleThres)
                continue;
            end

            found = false;
            for k = 1 : length(regionList)
                region2 = regionList{k};
                regionDiff = xor(region2, region1);
                if sum(regionDiff(:)) < diffThreshold
                    found = true;
                    sum1 = sum(region1(:));
                    sum2 = sum(region2(:));
                    if (sum1 > sum2)
                        % now region is bigger, change list content to region1
                        % or else keep list item unchange
                        regionList{k} = region1;
                    end
                    break;
                end
            end
            if ~found
                regionList{length(regionList) + 1} = region1;
                regionSizeList(size(regionSizeList) + 1) = sum(region1(:));
            end
        end
    end

    % sort region list from small to big
    sortList = [(1:length(regionList))', regionSizeList];
    sortList = sortrows(sortList, 2);

    result = zeros(height, width);
    for i = 1 : length(regionList)
        region = regionList{sortList(i, 1)};
        intersect = true;
        for j = 1 : size(result, 3)
            region2 = result(:, :, j);
            regionDiff = xor(region, region2);
            if sum(regionDiff(:)) == 0
                region2 = or(region2, region);
                result(:,:,j) = region2 + result(:,:,j);
                intersect = false;
                break;
            end
        end
        if intersect
            result(:,:,size(result, 3) + 1) = region;
        end
    end
end
