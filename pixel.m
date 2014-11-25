% Given a position p and an image im returns a value v
function [v] = pixel(p, im)
%%
v = im(sub2ind(size(im), p(1), p(2)));