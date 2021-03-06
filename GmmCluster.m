function [ centers ] = GmmCluster( img, k )
% Get image color distribute centers using GMM
% k is max cluster number
    [height, width, channel] = size(img);
    rgbVec = reshape(img, [height*width, channel]);
    if channel == 3
        figure;
        scatter3(rgbVec(:,1), rgbVec(:,2), rgbVec(:,3));
    else
        disp('image dimension error');
        return;
    end
    
    rgbVec = double(rgbVec);
    options = statset('MaxIter',500);
    
    lastGmm = {};
    tic;
    n = 2;
    while n <= k
        try
            gmm = fitgmdist(rgbVec, n,'Options',options, 'RegularizationValue',0.1);
        catch exception
            disp(['fit error at k = ', num2str(n), ' error message is:']);
            disp(exception.message);
            n = n - 1;
            continue;
        end
        disp(['n = ', num2str(n), ' AIC = ', num2str(gmm.AIC)]);
        if ~isempty(lastGmm) && lastGmm.AIC < gmm.AIC
            % smallest AIC indicates the best cluster number
            gmm = lastGmm;
            n = n - 1;
            break;
        end
        lastGmm = gmm;
        n = n + 1;
    end
    t = toc;
    fprintf('GMM cluster %d main color done: %1.2f sec\n', n, t);
    
    % TODO:centers有时会重复，应该能够去掉重复或相近值
    centers = gmm.mu;
    clusterData = cluster(gmm, rgbVec);
    figure;
    hold on;
    for i = 1 : n
        cluster1 = (clusterData == i);
        scatter3(rgbVec(cluster1, 1), rgbVec(cluster1, 2), rgbVec(cluster1, 3), 10, centers(i, :)./255);
    end
    hold off;
    xlim([0, 255]);
    ylim([0, 255]);
    zlim([0, 255]);
end

