function centers = HueCurveCenters( curve, minSegPixCount, minHueDelta )
%��ȡHue���ߵ�ƽ�����򣬲����������ĵ��б�
%curve�������Hue����Ӧ��������ĵ����ݼ�����
%   centers��ʽ��[hue, hue radius]

    % ȷ������Ĳ���
    totalStepCnt = 100;
    curveSize = size(curve); curveSize = curveSize(2);
    step = ceil(curveSize / totalStepCnt);
    totalStepCnt = floor(curveSize / step);

    % ����centers, Hue�����ǵ����ݼ���
    segStart = -1; segEnd = -1;
    centerCnt = 1;
    totalDelta = zeros(1, totalStepCnt);
    for i = 1 : totalStepCnt
        % ����hue�仯��
        delta = curve((i-1)*step + 1) - curve(i*step);
        totalDelta(i) = delta;
        if delta < 0
            disp('Hue ����б��Ϊ����something wrone!');
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

