% Returns S^q next given S^(q-1) curr, edge edge and image im
function [next] = seg_step(curr, edge, im)
%%
vi = edge(2);
vj = edge(3);
compi = which_component(vi, curr);
compj = which_component(vj, curr);

if compi ~= compj
    % vi and vj are in separate components
    w = edge(1);
    mint = MInt(compi, compj, im);
    if w <= mint
        % merge compi and compj
        % TODO: implement
    end
end