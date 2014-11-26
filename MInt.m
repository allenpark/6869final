% Given components c1 and c2 and image im, computes the difference between
% c1 and c2.
function [diff] = MInt(c1, c2, im)
%%
int1 = Int(c1, im) + thres(c1, im);
int2 = Int(c2, im) + thres(c2, im);
diff = min(int1, int2);