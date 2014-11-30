% Given components c1 and c2 and image im, computes the difference between
% c1 and c2.
function [diff] = MInt(c1, c2, seg, im)
%%
int1 = Int(c1, seg, im) + thres(c1, seg, im);
int2 = Int(c2, seg, im) + thres(c2, seg, im);
diff = min(int1, int2);