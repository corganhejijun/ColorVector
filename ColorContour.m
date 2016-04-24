function colorDistMat = ColorContour(fig, mainColors)
% ��ͼ����ÿ�������ɫ����
%%
% ������ɫ��8��, white, red, green, blue, yellow, cyan, purple, black.
% ����ֵ���ColorVectorע��.
    tic;
    basicColorType = size(mainColors, 1);
    colorDistMat = zeros([size(fig(:,:,1)), basicColorType]);
    for i = 1 : size(fig, 1)
        for j = 1 : size(fig, 2)
            colorDistMat(i, j, :) = ColorVector(reshape(double(fig(i, j, :)), [1, 3]), mainColors);
        end
    end
    t = toc;
    fprintf('color contour done: %1.2f sec\n', t);
    
%% ��ʾcolor vector ������
    figure;
    for i = 1 : basicColorType
        oneMat = colorDistMat(:, :, i);
        colorDistMat(:, :, i) = oneMat ./ max(oneMat(:));
        handle = subplot(2, 4, i);
        CreateColorContourFigure(colorDistMat(:, :, i), fig, handle);
    end
end