function [ labelImg ] = labelSeg( idxMap )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    max_label_area = 100;
    min_hole_area = 10;
    se = strel('disk',10); 
    same_area_ratio = 0.1;
    
    [height, width] = size(idxMap);
    maxIdx = max(idxMap(:));
    resultImg = zeros(height, width);
    label = 1;
    area = [];
    for i = 1 : maxIdx
        imgSeg = (idxMap == i);
        imgSegLabel = bwlabel(imgSeg);
        maxLabel = max(imgSegLabel(:));
        for j = 1 : maxLabel
            labelSeg = (imgSegLabel == j);
            a = sum(labelSeg(:));
            if a < max_label_area
                continue
            end
            area(label) = a;
            resultImg = resultImg + labelSeg * label;
            label = label + 1;
        end
    end
    [~, I] = sort(area, 'descend');
    labelImg = zeros(height, width);
    for i = 1 : length(I)
        if I(i) == -1
            continue;
        end
        imgMap = (resultImg == I(i));
        % fill zero index holes
        imgMapFill = imfill(imgMap, 'holes');
        imgMapholes = imgMapFill & (xor(imgMapFill, imgMap));
        imgMap(imgMapholes == 1) = I(i);
        % add new region
        labelImg = labelImg + (imgMap & xor(imgMap, labelImg));
        imgMap = imdilate(imgMap, se);
        % combine new regions
        for j = i+1 : length(I)
            nextMap = (resultImg == I(j));
            diffMap = xor((nextMap & imgMap), nextMap);
            if sum(diffMap(:))/sum(nextMap(:)) < same_area_ratio
                I(j) = -1;
                labelImg = labelImg + (nextMap & xor(nextMap, labelImg));
            end
        end
        labelImg = labelImg + (labelImg > 0);
    end
    %labelImg = labelImg + (labelImg == 0);
end

