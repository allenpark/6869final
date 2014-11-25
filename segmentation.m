% Takes an image im and returns a list of the segments
function [seg]=segmentation(im)
%%
% TODO: implement
% 0. Sort E into pi=(o_1, ..., o_m) by non-decreasing edge weight.
% 1. Start with a segmentation S_0, where each vertex v_i is in its own 
% component.
% 2. Repeat step 3 for q = 1, . . . , m.
% 3. Run seg_step on S^(q-1) to generate S^q.
% 4. Return S = S^m.