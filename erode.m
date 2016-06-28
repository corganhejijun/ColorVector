originalBW = imread('circles.png');  
%originalBW = imfill(originalBW, 'holes');
se = strel('disk',5);        
erodedBW = imdilate(originalBW,se);
imshow(originalBW), figure, imshow(erodedBW)