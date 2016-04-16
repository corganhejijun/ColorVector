function colorDistMat = ColorContour(fig)
% ��ͼ����ÿ�������ɫ����
%%
% ������ɫ��8��, white, red, green, blue, yellow, cyan, purple, black.
% ����ֵ���ColorVectorע��.
% TODO: ͨ�����෽���Զ���ȡͼƬ�е���Ҫ��ɫ����
    tic;
    basicColorType = 8;
    colorDistMat = zeros([size(fig(:,:,1)), basicColorType]);
    for i = 1 : size(fig, 1)
        for j = 1 : size(fig, 2)
            colorDistMat(i, j, :) = ColorVector(reshape(double(fig(i, j, :)), [1, 3]));
        end
    end
    t = toc;
    fprintf('color contour done: %1.2f sec\n', t);
    
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
end