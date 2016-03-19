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
    
    colorNames = {'white', 'red', 'green', 'blue', 'yellow', 'cyan', 'purple', 'black'};
    for i = 1 : basicColorType
        figure;
        surf(colorDistMat(:, :, i), fig, 'edgecolor', 'none', 'FaceColor', 'texturemap');
        title(colorNames(i));
    end
end