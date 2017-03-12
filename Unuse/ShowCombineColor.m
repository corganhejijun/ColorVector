function ShowCombineColor( combineColor )
% Show combineColor cells in a proper way
%   show all disjoint regions in one figure

    % sort cells so small regions can be display first
    index = zeros(1, length(combineColor));
    for i = 1 : length(combineColor)
        index(i) = sum(combineColor{i}(:));
    end
    index = [1:length(combineColor); index]';
    sortIndex = sortrows(index, 2);

    figureList = {};
    for i = 1 : length(combineColor)
        found = false;
        for j = 1 : length(figureList)
            oneFigure = figureList{j};
            if isempty(or(oneFigure, combineColor{sortIndex(i, 1)}))
                oneFigure = oneFigure + (oneFigure > 0) + combineColor{sortIndex(i, 1)};
                figureList{j} = oneFigure;
            end
        end
        if ~found
            figureList{length(figureList) + 1} = combineColor{sortIndex(i, 1)};
        end
    end

    % show figure
    for i = 1 : length(figureList)
        figure;imagesc(figureList{i});
    end
end

