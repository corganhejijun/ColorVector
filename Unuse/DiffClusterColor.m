function clusterDiff = DiffClusterColor(clusterResult)
% 将cluster聚类的结果通过差分计算边缘

    %以edgeWidth为宽度的四边形邻域内的像素
    edgeWidth = ceil(max(size(clusterResult)) / 300);
    totalHeight = size(clusterResult, 1);
    totalWdith = size(clusterResult, 2);
    clusterDiff = zeros([totalHeight, totalWdith]);
    for j = 1 : totalWdith
        for i = 1 : totalHeight
            sum = 0;
            for k = 1 : size(clusterResult, 3)
                a = clusterResult(i, j, k);
                for m = 1 : edgeWidth
                    for n = 1 : edgeWidth
                        if i > m && j > n
                            leftUp = abs(a - clusterResult(i - m, j - n, k));
                        else
                            leftUp = 0;
                        end
                        if i + m <= totalHeight && j + n <= totalWdith
                            rightDown = abs(a - clusterResult(i + m, j + n, k));
                        else
                            rightDown = 0;
                        end
                        if i + m <= totalHeight && j > n
                            rightUp = abs(a - clusterResult(i + m, j - n, k));
                        else
                            rightUp = 0;
                        end
                        if  i > m && j + n <= totalWdith
                            leftDown = abs(a - clusterResult(i - m, j + n, k));
                        else
                            leftDown = 0;
                        end
                        sum = sum + leftUp + rightDown + rightUp + leftDown;
                    end
                end
            end
            clusterDiff(i, j) = sum;
        end
    end

    figure;
    imagesc(clusterDiff);
end