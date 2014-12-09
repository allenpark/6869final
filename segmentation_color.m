% Takes a color image im and returns a segmentation
function [compmap]=segmentation_color(colorim, usefeaturespace, displaying)
if nargin <= 1
    usefeaturespace = true;
    displaying = true;
elseif nargin <= 2
    displaying = false;
end
if usefeaturespace
    [~, compmap] = segmentation(colorim, 0, displaying);
    return
end
%%
tic
segs = cell(3, 1);
compmaps = cell(3, 1);
parfor i=1:3
    [segs{i}, compmaps{i}] = segmentation(colorim(:, :, i), i, false);
end
if displaying
    for i=1:3
        vis_seg(segs{i}, colorim(:, :, i));
    end
end
toc
%%
tic
sz = size(colorim);
base = sz(1)*sz(2);
base2 = base * base;
compmap = zeros(sz(1)*sz(2), 1);
c1 = compmaps{1};
c2 = compmaps{2};
c3 = compmaps{3};
for i=1:sz(1)*sz(2)
    compmap(i) = base2 * c1(i) + base * c2(i) + c3(i);
end
x = unique(compmap);
parfor i=1:sz(1)*sz(2)
    found = -1;
    for j=1:size(x, 1)
        if x(j) == compmap(i)
            found = j;
            break
        end
    end
    compmap(i) = found;
end
toc
%%
colors = rand(size(x, 1), 3);
rgbim = im2double(ind2rgb(reshape(compmap, [sz(1) sz(2)]), colors));
figure;
imshow(imresize(rgbim, [512 512]));
figure;
origim = im2double(rgb2gray(colorim));
imshow(imresize(repmat(origim, 1, 1, 3) .* rgbim, [512 512]));
figure;
imshow(imresize(colorim, [512 512]));