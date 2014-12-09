% Takes a list of segments seg and an image im and shows a segmented image
function [] = vis_seg(seg, im)
%%
sz = size(im);
indim = zeros(sz(1), sz(2));
segsz = size(seg);
for i = 1:segsz(1)
    segment_nodes = seg{i, 1};
    for j = 1:length(segment_nodes)
        [subi, subj] = ind2sub(sz, segment_nodes(j));
        indim(subi, subj) = i;
    end
end
colormap = rand(segsz(1), 3);
rgbim = im2double(ind2rgb(indim, colormap));
if size(im, 3) == 1
    blended = repmat(im2double(im), 1, 1, 3) .* rgbim;
else
    blended = im2double(im) .* rgbim;
end

% figure;
% subplot(1, 2, 1);
% subimage(im);
% subplot(1, 2, 2);
% subimage(indim, colormap);
% subplot(1, 3, 3);
% subimage(blended);
figure;
imshow(imresize(im, [512 512]));
figure;
imshow(imresize(rgbim, [512 512]));
figure;
imshow(imresize(blended, [512 512]));