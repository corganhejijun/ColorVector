function centers = HueCurveCenters( curve, minSegPixCount, minHueDelta )
%获取Hue曲线的平滑区域，并返回其中心点列表
%curve：传入的Hue曲线应是排序过的单调递减曲线
%   centers格式：[hue, hue radius]

    % 确定计算的步长
    totalStepCnt = 100;
    curveSize = size(curve); curveSize = curveSize(2);
    step = ceil(curveSize / totalStepCnt);
    totalStepCnt = floor(curveSize / step);

    % 计算centers, Hue曲线是单调递减的
    segStart = -1; segEnd = -1;
    centerCnt = 1;
    totalDelta = zeros(1, totalStepCnt);
    for i = 1 : totalStepCnt
        % 计算hue变化量
        delta = curve((i-1)*step + 1) - curve(i*step);
        totalDelta(i) = delta;
        if delta < 0
            disp('Hue 曲线斜率为正，something wrone!');
            break;
        end
        if delta < minHueDelta
            if segStart == -1
                segStart = i - 1;
            end
            segEnd = i;
        else
            if segStart ~= -1 && segEnd > segStart && (segEnd - segStart) >= minSegPixCount
                hueRadius = (curve(segStart * step + 1) - curve(segEnd * step)) / 2;
                hueCenter = curve(segStart * step + 1) - hueRadius;
                centers{centerCnt} = [hueCenter, hueRadius];
                centerCnt = centerCnt + 1;
                segEnd = -1; segStart = -1;
            end
        end
    end
end

