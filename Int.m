% Given component c and image im, computes the internal difference of c.
function [in_diff] = Int(c, seg, im)
%%
sz = size(im);
comp_nodes = seg{c, 1};
szc = size(comp_nodes);
in_diff = seg{c, 2};
% 
% % Generate edge list from nodes
% edges = zeros(szc*szc, 3);
% for i = 1:szc
%     for j = 1:szc
%         ind = (i-1)*szc + j;
%         edges(ind, 1) = i;
%         edges(ind, 2) = j;
%         edges(ind, 3) = edge_weight(c(i), c(j));
%     end
% end
% 
% sparse_matrix = sparse(edges(:, 1), edges(:, 2), edges(:, 3), sz(1), sz(2), szc);
% [Tree, ~] = graphminspantree(sparse_matrix);
% [~, ~, tree_edges] = find(Tree);
% in_diff = max(tree_edges);