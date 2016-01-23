function colorDis = ColorDistance(color1, color2)
    base = 1/1.022;
    colorDis = base^norm(color1 - color2)*255;
end