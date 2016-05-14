function [ combineRegionImgList ] = CombineSameColorRegions(img, regionList )
% combine regions with same color distribution
    combineRegionImgList = {};
    combineRegionList = {};
    tic;
    for i = 1 : length(regionList)
        regionImg = zeros(size(img));
        for k = 1 : size(img, 3)
            regionImg(:,:,k) = regionList{i};
        end
        % image with double value have range [0,1] at each channel
        regionImg = regionImg .* (double(img)./255);
        hasSameColor = false;
        for j = 1 : length(combineRegionImgList)
            combineRegion = combineRegionImgList{j};
            if SameColorDistribute(combineRegion, regionImg)
                hasSameColor = true;
                % combine binary regions
                combineRegionList{j} = or(regionList{i}, combineRegionList{j});
                for k = 1 : size(img, 3)
                    combineRegion(:,:,k) = combineRegionList{j};
                end
                % convert binary regions into rgb regions of image
                combineRegion = combineRegion .* (double(img)./255);
                combineRegionImgList{j} = combineRegion;
                break;
            end
        end
        if ~hasSameColor
            combineRegionImgList{length(combineRegionImgList) + 1} = regionImg;
            combineRegionList{length(combineRegionList) + 1} = regionList{i};
        end
    end
    t = toc;
    fprintf('combine same color regions done: %1.2f sec\n', t);
end

