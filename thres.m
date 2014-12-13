% Given component c and image im, computes the threshold function of c.
function [t] = thres(c, num_comp, seg, im)
%%
comp_nodes = seg{c, 1};
t = 0.7 / length(comp_nodes) + .1/256;
