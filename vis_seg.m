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
imshow(indim, colormap);