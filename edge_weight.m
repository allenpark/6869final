% Takes two positions p1 and p2 and an image im and returns the edge weight
% between the two positions
function [weight] = edge_weight(p1, p2, im)
%%
difx = abs(p1(1) - p2(1));
dify = abs(p1(2) - p2(2));
if difx <= 1 && dify <= 1
    val1 = pixel(p1, im);
    val2 = pixel(p2, im);
    weight = abs(val1 - val2);
else
    error('comparing p1 (%d, %d) and p2 (%d, %d)', p1(1), p1(2), p2(1), p2(2));
end