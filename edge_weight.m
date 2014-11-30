% Takes two positions p1 and p2 and an image im and returns the edge weight
% between the two positions
function [weight] = edge_weight(p1, p2, im)
%%
if abs(p1(1) - p2(1)) == 1 || abs(p1(2) - p2(2)) == 1
    val1 = pixel(p1, im);
    val2 = pixel(p2, im);
    weight = abs(val1 - val2);
else
    weight = 0;
end