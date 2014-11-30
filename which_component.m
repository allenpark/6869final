% Given a vertex v and a segmentation s, returns which component v is in.
function [w] = which_component(v, s)
%%
for i = 1:length(s)
    comp_nodes = s{i, 1};
    comp_size = size(comp_nodes);
    for j = 1:comp_size(2)
        if v == comp_nodes(j)
            w = i;
            return;
        end
    end
end
error(strcat('Error in which_component: Could not find ', num2str(v)));
