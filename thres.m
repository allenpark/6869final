% Given component c and image im, computes the threshold function of c.
function [t] = thres(c, seg, im)
%%
comp_nodes = seg{c, 1};
t = 500 / length(comp_nodes);