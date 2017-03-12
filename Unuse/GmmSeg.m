%%
clear; close all; clc;
imgFolder = 'images/test/';
outFolder = 'result/test/';
showFolder = 'result/show/';

%%
imgFiles = dir([imgFolder, '*.jpg']);
times = [];
for i = 1 : length(imgFiles)
    disp(imgFiles(i).name);
    close all;
    [~, name, ~] = fileparts(imgFiles(i).name);
    if exist([outFolder, name, '.mat'], 'file')
        continue;
    end
    img = imread([imgFolder, imgFiles(i).name]);
    [height, width, channelCnt] = size(img);
    t1 = clock;
    [idxMap, divideTree]= GmmBiDivide(img, true);
    [superPixel, numlabels] = slicmex(img,500,20);
    seg = labelSeg(reshape(idxMap, height, width));
    
%     superPixelSeg = zeros(height, width);
%     for k = 0 : (numlabels-1)
%         label = double(superPixel == k);
%         labelArea = label .* seg;
%         superPixelIdx = -1;
%         superPixelArea = 0;
%         for j = min(labelArea(:)) : max(labelArea(:))
%             area = double(labelArea == j & label == 1);
%             area = sum(area(:));
%             if superPixelArea < area
%                 superPixelArea = area;
%                 superPixelIdx = j;
%             end
%         end
%         superPixelSeg = superPixelSeg + label * superPixelIdx;
%     end
    
    segs = {seg};
    times(i) = etime(clock, t1);
    save([outFolder, name, '.mat'], 'segs');
    figure;subplot(1, 2 ,1);imagesc(img);
    subplot(1, 2, 2);imagesc(segs{1});
    saveas(gcf, [showFolder, imgFiles(i).name], 'jpg');
end