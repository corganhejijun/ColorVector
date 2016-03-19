function HueCurveContour(filePath)
    fig = imread(filePath);
    hsvFig = rgb2hsv(fig); %ת��Ϊhsvͼ��������ڷָ�
    hue = hsvFig(:,:,1);
    saturation = hsvFig(:,:,2);    %hueȡֵ�ò������ڰ�ɫ�����ͶȺ��������ڷָ�ڰ�������ɫ
    % ��valueС��0.2ʱ��Ϊ��ɫ����saturationС��0.1ʱ��ͼ���Ϊ�ڰ�
    value = hsvFig(:,:,3);
    [width, height] = size(hue);
    hueSort = reshape(hue, [1, width * height]);
    hueSort = sort(hueSort, 'descend');
    minSegPixCount = 0.05;  %�ָ�����ռȫ���������С�ٷֱ�
    minHueDelta = 0.005;     %���Ͷȱ仯�����Χ�����Ͷȱ仯̫����˵�����ز�����ͬһ������
    centers = HueCurveCenters(hueSort, minSegPixCount, minHueDelta);
    hueMap = zeros(size(hue, 1), size(hue, 2), size(centers, 2));
    for i = 1 : size(centers, 2)
        center = centers{i};
        radius = center(2);
        center = center(1);
        for j = 1 : size(hue, 2)
            for k = 1 : size(hue, 1)
                if hue(k, j) > center - radius && hue(k, j) < center + radius && value(k, j) > 0.2 && saturation(k, j) > 0.1
                    hueMap(k, j, i) = 1;
                end
            end
        end
        figure;
        surf(hueMap(:, :, i), fig,'edgecolor', 'none','FaceColor','texturemap')
    end
end