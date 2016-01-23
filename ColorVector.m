function colorVector = ColorVector(rgbColor)
    white   = [0, 0, 0];
    red     = [255, 0, 0];
    green   = [0, 255, 0];
    blue    = [0, 0, 255];
    yellow  = [255, 255, 0];
    cyan    = [0, 255, 255];
    purple  = [255, 0, 255];
    black   = [255, 255, 255];
%     w = [255, 0, 0, 0, 0, 0, 0, 0];
%     r = [0, 255, 0, 0, 0, 0, 0, 0];
%     g = [0, 0, 255, 0, 0, 0, 0, 0];
%     b = [0, 0, 0, 255, 0, 0, 0, 0];
%     y = [0, 0, 0, 0, 255, 0, 0, 0];
%     c = [0, 0, 0, 0, 0, 255, 0, 0];
%     p = [0, 0, 0, 0, 0, 0, 255, 0];
%     d = [0, 0, 0, 0, 0, 0, 0, 255];
    colorVector = [ColorDistance(rgbColor, white), ColorDistance(rgbColor, red), ...
        ColorDistance(rgbColor, green), ColorDistance(rgbColor, blue), ...
        ColorDistance(rgbColor, yellow), ColorDistance(rgbColor, cyan), ...
        ColorDistance(rgbColor, purple), ColorDistance(rgbColor, black)];
end