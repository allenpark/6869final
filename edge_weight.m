% Takes two positions p1 and p2 and an image im and returns the edge weight
% between the two positions
function [weight] = edge_weight(p1, p2, im)
%%
val1 = pixel(p1, im);
val2 = pixel(p2, im);
weight = abs(val1 - val2);