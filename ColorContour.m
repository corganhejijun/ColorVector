function colorDistMat = ColorContour(fig)
% ��ͼ����ÿ�������ɫ����
%%
% ������ɫ��8��, white, red, green, blue, yellow, cyan, purple, black.
% ����ֵ���ColorVectorע��.
% TODO: ͨ�����෽���Զ���ȡͼƬ�е���Ҫ��ɫ����
    basicColorType = 8;
    colorDistMat = zeros([size(fig(:,:,1)), basicColorType]);
    for i = 1 : size(fig, 1)
        for j = 1 : size(fig, 2)
            colorDistMat(i, j, :) = ColorVector(reshape(double(fig(i, j, :)), [1, 3]));
        end
    end
    
%% ��ʾcolor vector ������
    colorNames = {'white', 'red', 'green', 'blue', 'yellow', 'cyan', 'purple', 'black'};
    figure;
    for i = 1 : basicColorType
        %figure;
        %surf(colorDistMat(:, :, i), fig, 'edgecolor', 'none', 'FaceColor', 'texturemap');
        oneMat = colorDistMat(:, :, i);
        colorDistMat(:, :, i) = oneMat ./ max(oneMat(:));
        handle = subplot(2, 4, i);
        CreateColorContourFigure(colorDistMat(:, :, i), fig, handle);
        title(colorNames(i));
    end
    
%% ����ÿ�������Ǳ�Ե���صĸ���
% 1 0 1 ����ԽǷ�����ĸ��������������صľ����ֵ��ȡ�����Ϊ���������Ե�ľ��룬
% 0 1 0 ����maxColorVectorDistance��Ϊ��Ե����
% 1 0 1  
% thresholdΪ��Ե��ֵ��a��b�ֱ�ΪС�ںʹ���thresholdʱ��Ե���ʵ��½����ʣ���Ե�������߱�ʾΪ
%   if x < threshold : prob = ax;
%   if x > threshold : prob = bx;
%   and prob ��С��1 �� ������0
%     threshold = 0.25;
%     a = 4;
%     b = -4;
%     vecDistRadius = floor(max(size(fig)) / 100);
%     colorVectorContourProb = zeros(size(colorDistMat));
%     for i = vecDistRadius + 1 : size(fig, 1) - vecDistRadius
%         for j = vecDistRadius + 1 : size(fig, 2) - vecDistRadius
%             for k = 1 : basicColorType
%                 upLeft = norm(colorDistMat(i, j, k) - colorDistMat(i - vecDistRadius, j - vecDistRadius, k));
%                 upRight = norm(colorDistMat(i, j, k) - colorDistMat(i - vecDistRadius, j + vecDistRadius, k));
%                 downLeft = norm(colorDistMat(i, j, k) - colorDistMat(i + vecDistRadius, j - vecDistRadius, k));
%                 downRight = norm(colorDistMat(i, j, k) - colorDistMat(i + vecDistRadius, j + vecDistRadius, k));
%                 maxVecDist = max([upLeft, upRight, downLeft, downRight]);
%                 prob = colorDistMat(i, j, k);
%                 if prob > threshold
%                     prob = prob * b + 1;
%                 elseif prob <= threshold
%                     prob = prob * a;
%                 end
%                 if prob < 0
%                     prob = 0;
%                 end
%                 colorVectorContourProb(i, j, k) = prob * maxVecDist;
%             end
%         end
%     end
end