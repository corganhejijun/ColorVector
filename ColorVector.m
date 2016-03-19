function colorVector = ColorVector(rgbColor)
%由RGB颜色转换为8种常见颜色, rgbColor为三元RGB向量
%     white = [255, 0, 0, 0, 0, 0, 0, 0];
%     red   = [0, 255, 0, 0, 0, 0, 0, 0];
%     green = [0, 0, 255, 0, 0, 0, 0, 0];
%     blue  = [0, 0, 0, 255, 0, 0, 0, 0];
%     yellow = [0, 0, 0, 0, 255, 0, 0, 0];
%     cyan  = [0, 0, 0, 0, 0, 255, 0, 0];
%     purple = [0, 0, 0, 0, 0, 0, 255, 0];
%     black = [0, 0, 0, 0, 0, 0, 0, 255];
    white   = [0, 0, 0];
    red     = [255, 0, 0];
    green   = [0, 255, 0];
    blue    = [0, 0, 255];
    yellow  = [255, 255, 0];
    cyan    = [0, 255, 255];
    purple  = [255, 0, 255];
    black   = [255, 255, 255];
    colorVector = [ColorDistance(rgbColor, white), ColorDistance(rgbColor, red), ...
        ColorDistance(rgbColor, green), ColorDistance(rgbColor, blue), ...
        ColorDistance(rgbColor, yellow), ColorDistance(rgbColor, cyan), ...
        ColorDistance(rgbColor, purple), ColorDistance(rgbColor, black)];
end