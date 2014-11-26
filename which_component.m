% Given a vertex v and a segmentation s, returns which component v is in.
function [w] = which_component(v, s)
for i = 1:length(s)
    comp = s{i};
    for j = 1:length(comp)
        if v == comp(j, :)
            w = j;
            return;
        end
    end
end
error(strcat('Error in which_component: Could not find ', v));
