% Takes an image im and returns a list of the segments
function [seg]=segmentation(im)
%%
% 0. Sort E into pi=(o_1, ..., o_m) by non-decreasing edge weight.
tic
unsorted_graph = init_graph(im);
[~, I] = sort(unsorted_graph(:, 1));
edges = unsorted_graph(I, :);
toc

%%
% 1. Start with a segmentation S_0, where each vertex v_i is in its own 
% component.
tic
sz = size(im);
m = sz(1);
n = sz(2);
seg = cell(m*n, 2);
for i = 1:m
    for j = 1:n
        new_comp = cell(1, 2);
        new_comp{1} = sub2ind(sz, i, j);
        new_comp{2} = 0;
        seg(sub2ind(sz, i, j), :) = new_comp;
    end
end
toc

%%
% 2. Repeat step 3 for q = 1, . . . , m.
% 3. Run seg_step on S^(q-1) to generate S^q.
tic
for q = 1:length(edges)
    fprintf('Starting q=%d out of %d %d\n', q, length(edges), size(seg));
    e = edges(q, :);
    seg = seg_step(seg, e, im);
end
toc

%%
% 4. Return S = S^m.
tic
vis_seg(seg, im);
toc
