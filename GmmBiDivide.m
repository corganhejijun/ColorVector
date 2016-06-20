function [ segMap, divideTree ] = GmmBiDivide( fig, showDivide )
%
    [height, width, channelCnt] = size(fig);
    % lab color space range, L=[0, 100], a = [-128, 127], b = [-128, 127]
    figVec = reshape(rgb2lab(fig), height*width, channelCnt);
    % bigger than this threshold will be consider as same color
    lu_thres = 20;
    color_thres = 2*pi/7;
    max_biDivideDeepth = 5;
    divideTree = [];

    % store image idx mask that need to be divide
    needDivideIdx = 1;
    % store all the idx masks
    gmmIdx = ones(height*width, 1);
    loopCount = 0;
    while (size(needDivideIdx, 2) > 0 && loopCount < max_biDivideDeepth)
        loopCount = loopCount + 1;
        % this value will change in for loop
        idxSize = size(needDivideIdx, 2);
        for i = 1 : idxSize
            if i > size(needDivideIdx, 2)
                break;
            end
            vec = figVec(gmmIdx==needDivideIdx(i),:);
            % gmm divide step
            options = statset('MaxIter',500);
            gmm = fitgmdist(vec,2,'Options',options);
            idx = cluster(gmm, vec);

            %the last element is the largest index
            maxIdx = max(gmmIdx) + 1;
            k = 1;
            % origin idx mask divided into two sections, one stay the old
            % idx mask, another section get an index of maxIdx+1, as idx
            % mask number increased by one
            for j = 1 : size(gmmIdx, 1)
                if gmmIdx(j) == needDivideIdx(i)
                    % if current pixel belong to cluster two, set idx mask
                    % to maxIdx+1, orelse this pixel belongs to cluster
                    % one, idx mask not change
                    if idx(k) == 2
                        gmmIdx(j) = maxIdx+1;
                    end
                    % k counts the pixel number of current idx mask section
                    k = k+1;
                end
            end

            % generate two new vec lists, each list contains only pixels
            % belong to the corresponding cluster
            vec1 = figVec(gmmIdx==needDivideIdx(i), :);
            vec2 = figVec(gmmIdx==maxIdx+1, :);
            lu_diff1 = max(vec1(:,1)) - min(vec1(:,1));
            lu_diff2 = max(vec2(:,1)) - min(vec2(:,1));
            colorAngleDiff1 = atan(vec1(:,2)./vec1(:,3));
            colorAngleDiff2 = atan(vec2(:,2)./vec2(:,3));
            colorDiff1 = max(colorAngleDiff1) - min(colorAngleDiff1);
            colorDiff2 = max(colorAngleDiff2) - min(colorAngleDiff2);
            
            if showDivide
                figList = reshape(fig, height*width, channelCnt);
                beforeDivide = zeros(height*width, channelCnt);
                combine = (gmmIdx==needDivideIdx(i)) + (gmmIdx==maxIdx+1);
                beforeDivide(combine==1, :) = figList(combine==1, :);
                beforeDivide = reshape(beforeDivide, height, width, channelCnt);
                beforeDivide = beforeDivide/255;
                afterDivide1 = zeros(height*width, channelCnt);
                afterDivide1(gmmIdx==needDivideIdx(i), :) = figList(gmmIdx==needDivideIdx(i), :);
                afterDivide1 = reshape(afterDivide1, height, width, channelCnt);
                afterDivide1 = afterDivide1/255;
                afterDivide2 = zeros(height*width, channelCnt);
                afterDivide2(gmmIdx==maxIdx+1, :) = figList(gmmIdx==maxIdx+1, :);
                afterDivide2 = reshape(afterDivide2, height, width, channelCnt);
                afterDivide2 = afterDivide2/255;
                figure;
                subplot(1,3,1);
                imagesc(beforeDivide);
                subplot(1,3,2);
                imagesc(afterDivide1);
                title(['luDiff1=', num2str(lu_diff1), ' colorDiff1=', num2str(colorDiff1)]);
                subplot(1,3,3);
                imagesc(afterDivide2);
                title(['lu_diff2=', num2str(lu_diff2), ' colorDiff2=', num2str(colorDiff2)]);
            end
            % check each cluster if they has the same color, which means
            % belong to the same segment and no need to divide
            
            % must add new idx before delete the old idx from the list,
            % orelse will make bug
            if lu_diff2 > lu_thres && colorDiff2 > color_thres
                needDivideIdx(size(needDivideIdx, 2)+1) = maxIdx+1;
                divideTree(size(divideTree, 1)+1, :) = [needDivideIdx(i), maxIdx+1];
            end
            if lu_diff1 < lu_thres || colorDiff1 < color_thres
                needDivideIdx(i) = [];
            end
        end
    end
    segMap = gmmIdx;
end

