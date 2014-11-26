% Takes an image im and returns a list of the segments
function [seg]=segmentation(im)
%%
% 0. Sort E into pi=(o_1, ..., o_m) by non-decreasing edge weight.
unsorted_graph = init_graph(im);
graph = sort(unsorted_graph, 'descend');

%%
% 1. Start with a segmentation S_0, where each vertex v_i is in its own 
% component.
sz = size(im);
m = sz(1);
n = sz(2);
seg = cell(m*n, 1);
for i = 1:m
    for j = 1:n
        seg(sub2ind(sz, i, j)) = [i j];
    end
end

%%
% 2. Repeat step 3 for q = 1, . . . , m.

%%
% 3. Run seg_step on S^(q-1) to generate S^q.

%%
% 4. Return S = S^m.

