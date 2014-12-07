% Given image im, initializes a graph connecting adjacent pixels
function [graph] = init_graph(im)
%%
sz = size(im);
m = sz(1);
n = sz(2);
graph = zeros(m*(n-1) + (m-1)*n + 2*(m-1)*(n-1), 3);
count = 1;
zcount = 0;
for i = 1:m
    for j = 1:n
        if i < m
            ew = edge_weight([i j], [i+1 j], im);
            graph(count, 1) = ew;
            graph(count, 2) = sub2ind(sz, i, j);
            graph(count, 3) = sub2ind(sz, i+1, j);
            count = count + 1;
            zcount = zcount + double(ew == 0);
        end
        if j < n
            ew = edge_weight([i j], [i j+1], im);
            graph(count, 1) = ew;
            graph(count, 2) = sub2ind(sz, i, j);
            graph(count, 3) = sub2ind(sz, i, j+1);
            count = count + 1;
            zcount = zcount + double(ew == 0);
        end
        if i < m && j < n
            ew = edge_weight([i j], [i+1 j+1], im);
            graph(count, 1) = ew;
            graph(count, 2) = sub2ind(sz, i, j);
            graph(count, 3) = sub2ind(sz, i+1, j+1);
            count = count + 1;
            zcount = zcount + double(ew == 0);
        end
        if i > 1 && j < n
            ew = edge_weight([i j], [i-1 j+1], im);
            graph(count, 1) = ew;
            graph(count, 2) = sub2ind(sz, i, j);
            graph(count, 3) = sub2ind(sz, i-1, j+1);
            count = count + 1;
            zcount = zcount + double(ew == 0);
        end
    end
end
if count-1 ~= size(graph, 1)
    error('init_graph count does not equal size(graph)');
end