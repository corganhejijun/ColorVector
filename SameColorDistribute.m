function [ result ] = SameColorDistribute( region1, region2 )
%Compare colors distribution of two regions, check if has the same colors.
    maxK = 8;
    sameColorThresholdDistance = 10/255;
    centers1 = GmmCluster(region1, maxK);
    centers2 = GmmCluster(region2, maxK);
    % make center1 be the longer color list 
    if size(centers1, 1) < size(centers2, 1)
        tmp = centers1;
        centers1 = centers2;
        centers2 = tmp;
    end

    % add each corresponding points distances
    % for each point in centers1, corresponding points is the closest point in centers2
    totalDistance = 0;
    for i = 1 : size(centers1, 1)
        center1 = centers1(i, :);
        distance = Inf;
        for j = 1 : size(centers2, 1)
            dist = norm(center1 - centers2(j, :));
            if (dist < distance)
                distance = dist;
            end
        end
        totalDistance = totalDistance + distance;
    end

    result = totalDistance < sameColorThresholdDistance;
end

