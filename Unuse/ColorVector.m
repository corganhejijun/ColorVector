function colorVector = ColorVector(rgbColor, mainColors)
%��RGB��ɫת��Ϊ8�ֳ�����ɫ, rgbColorΪ��ԪRGB����
%     white = [255, 0, 0, 0, 0, 0, 0, 0];
%     red   = [0, 255, 0, 0, 0, 0, 0, 0];
%     green = [0, 0, 255, 0, 0, 0, 0, 0];
%     blue  = [0, 0, 0, 255, 0, 0, 0, 0];
%     yellow = [0, 0, 0, 0, 255, 0, 0, 0];
%     cyan  = [0, 0, 0, 0, 0, 255, 0, 0];
%     purple = [0, 0, 0, 0, 0, 0, 255, 0];
%     black = [0, 0, 0, 0, 0, 0, 0, 255];
%     white   = [255, 255, 255];
%     red     = [255, 0, 0];
%     green   = [0, 255, 0];
%     blue    = [0, 0, 255];
%     yellow  = [255, 255, 0];
%     cyan    = [0, 255, 255];
%     purple  = [255, 0, 255];
%     black   = [0, 0, 0];
    colorType = size(mainColors, 1);
    colorVector = zeros(1, colorType);
    for i = 1 : colorType
        colorVector(i) = ColorDistance(rgbColor, mainColors(i, :));
    end
end