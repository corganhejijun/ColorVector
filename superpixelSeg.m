clear; close all; clc;
img = imread('12003.jpg');
[height, width, channelCnt] = size(img);

%% superpixel
[superPixel, numlabels] = slicmex(img,500,20);%numlabels is the same as number of superpixels

%% Gmm divide
[idxMap, divideTree]= GmmBiDivide(img, true);
idxImg = reshape(idxMap, height, width);
segs = labelSeg(idxImg);
figure; imagesc(segs);

%%
superPixelSeg = zeros(height, width);
for i = 0 : (numlabels-1)
    label = double(superPixel == i);
    labelSeg = label .* segs;
    superPixelIdx = -1;
    superPixelArea = 0;
    for j = min(labelSeg(:)) : max(labelSeg(:))
        area = double(labelSeg == j & label == 1);
        area = sum(area(:));
        if superPixelArea < area
            superPixelArea = area;
            superPixelIdx = j;
        end
    end
    superPixelSeg = superPixelSeg + label * superPixelIdx;
end

%%
maxIdx = max(superPixelSeg(:));
se = strel('disk', 3);
for i = 0 : maxIdx - 1
    idxMap1 = superPixelSeg == i;
    if sum(idxMap1(:)) == 0
        continue;
    end
    idxMap1 = imdilate(double(idxMap1), se);
    for j = i + 1 : maxIdx
        idxMap2 = superPixelSeg == j;
        if sum(idxMap2(:)) == 0
            continue;
        end
        idxMap2 = imdilate(double(idxMap2), se);
        interMap = (idxMap1 == 1) & (idxMap2 == 1);
        if sum(interMap(:)) == 0
            continue;
        else
            mask = repmat(interMap, [1,1,3]);
            mask = uint8(mask);
            maskImg = img .* mask;
            [gradX, gradY, gradZ] = gradient(double(maskImg));
        end
    end
end

%%
figure; imagesc(superPixelSeg);
figure; imagesc(img);