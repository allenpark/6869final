% Given component c and image im, computes the threshold function of c.
function [t] = thres(c, num_comp, seg, im)
%%
comp_nodes = seg{c, 1};
t = 1000 / length(comp_nodes);
