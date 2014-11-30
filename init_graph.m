% Given image im, initializes a graph connecting adjacent pixels
function [graph] = init_graph(im)
%%
sz = size(im);
m = sz(1);
n = sz(2);
initial_graph = zeros(m*(n-1) + (m-1)*n, 3);
count = 1;
for i = 1:m
    for j = 1:n
        if i < m
            ew = edge_weight([i j], [i+1 j], im);
            if true || ew > 1
                initial_graph(count, 1) = ew;
                initial_graph(count, 2) = sub2ind(sz, i, j);
                initial_graph(count, 3) = sub2ind(sz, i+1, j);
                count = count + 1;
            end
        end
        if j < n
            ew = edge_weight([i j], [i j+1], im);
            if true || ew > 1
                initial_graph(count, 1) = ew;
                initial_graph(count, 2) = sub2ind(sz, i, j);
                initial_graph(count, 3) = sub2ind(sz, i, j+1);
                count = count + 1;
            end
        end
    end
end
graph = zeros(count-1, 3);
for i = 1:count-1
    graph(i, :) = initial_graph(i, :);
end