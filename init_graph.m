% Given image im, initializes a graph connecting adjacent pixels
function [graph] = init_graph(im)
%%
sz = size(im);
m = sz(1);
n = sz(2);
graph = zeros(m*(n-1) + (m-1)*n, 3);
count = 1;
for i = 1:m
    for j = 1:n
        if i < m
            graph(count, :) = [edge_weight([i j], [i+1 j], im) sub2ind(sz, i, j) sub2ind(sz, i+1, j)];
            count = count + 1;
        end
        if j < n
            graph(count, :) = [edge_weight([i j], [i j+1], im) sub2ind(sz, i, j) sub2ind(sz, i, j+1)];
            count = count + 1;
        end
    end
end
