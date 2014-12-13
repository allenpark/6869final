% Given components c1 and c2 and image im, computes the difference between
% c1 and c2.
function [diff, c] = MInt(c1, c2, num_comp, seg, im)
%%
int1 = Int(c1, seg, im) + thres(c1, num_comp, seg, im);
int2 = Int(c2, seg, im) + thres(c2, num_comp, seg, im);
if int1 < int2
    diff = int1;
    c = c1;
else
    diff = int2;
    c = c2;
end