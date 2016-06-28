%%
clear; close all; clc;
imgFolder = 'images/test/';
outFolder = 'result/test/';

%%
imgFiles = dir([imgFolder, '*.jpg']);
for i = 1 : length(imgFiles)
    disp(imgFiles(i).name);
    close all;
    [~, name, ~] = fileparts(imgFiles(i).name);
    if exist([outFolder, name, '.mat'], 'file')
        continue;
    end
    img = imread([imgFolder, imgFiles(i).name]);
    [height, width, channelCnt] = size(img);
    [idxMap, divideTree]= GmmBiDivide(img, true);
    segs = {};
    segs{1} = labelSeg(reshape(idxMap, height, width));
    save([outFolder, name, '.mat'], 'segs');
    figure;subplot(1, 2 ,1);imagesc(img);
    subplot(1, 2, 2);imagesc(segs{1});
end