% Takes two positions p1 and p2 and an image im and returns the edge weight
% between the two positions
function [weight] = edge_weight(p1, p2, im)
%%
% TODO: implement
weight = im(p1) - im(p2);