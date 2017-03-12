function lengthMat = TrackLine(outline, startX, startY)
% return length in pixel, every pixel in outline is set to length
    lineList = [startX, startY];
    lineList = TrackOneStep(outline, lineList);
    lengthMat = zeros(size(outline));
    listLength = size(lineList, 1);
    for i = 1 : listLength
        lengthMat(lineList(i, 1), lineList(i, 2)) = listLength;
    end
end

function lineListOut = TrackOneStep(img, lineList)
    lineListOut = lineList;
    pos = lineListOut(end, :);
    lastValue = 0;
    if (size(lineListOut, 1) > 1)
        lastPos = lineListOut(end - 1, :);
        lastValue = [lastPos(1), lastPos(2)];
    end
    % all zero but current point and last point, is the end of outline
    if sum(sum(img(pos(1)-1:pos(1)+1, pos(2)-1:pos(2)+1))) - img(pos(1),pos(2)) - lastValue == 0
        return;
    end
    % 8 directions
    directions = [-1, -1; -1, 0; -1, 1; 0, -1; 0, 1; 1, -1; 1, 0; 1, 1];
    for i = 1 : 8
        if pos(1) + directions(i, 1) <= 0 || pos(2) + directions(i, 2) <= 0
            continue;
        end
        if lastValue == pos + directions(i, :)
            continue;
        end
        if img(pos(1) + directions(i, 1), pos(2) + directions(i, 2)) > 0
            % outline loop
            find = 0;
            for j = 1 : size(lineListOut, 1)
                if lineListOut(j, :) == pos + directions(i, :)
                    find = 1;
                    break;
                end
            end
            if find == 0
                lineListOut(size(lineListOut, 1) + 1, :) = pos + directions(i, :);
                lineListOut = TrackOneStep(img, lineListOut);
            end
        end
    end
end