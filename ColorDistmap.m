function [ distMap ] = ColorDistmap( img )
%
[height, width, ~] = size(img);
img = double(img);
distMap = zeros(height, width);
distMap2 = zeros(height, width);
for i = 1 : height - 1
    for j = 1 : width - 1
        a = img(i, j, :);
        b = img(i, j + 1, :);
        c = img(i + 1, j, :);
        distMap(i, j) = norm(a(:)-b(:));
        distMap2(i, j) = norm(a(:)-c(:));
    end
end
figure; imagesc(distMap);
figure; imagesc(distMap2);
end

