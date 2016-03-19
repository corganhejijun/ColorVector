function colorDis = ColorDistance(color1, color2)
% 计算两种颜色的距离, 返回值为0~255
%% 
% norm计算欧氏距离
% base为调整后的系数
% 使用指数函数的第一象限部分，保证输出结果在0~255之间，且保持一定的下降速度
% 执行下面代码查看曲线变化范围
%   a = 0 : norm([255, 255, 255]);
%   b = (1/1.002).^a;
%   plot(a, 255 * b)
    base = 1/1.022;
    colorDis = (base^norm(color1 - color2))*255;
end