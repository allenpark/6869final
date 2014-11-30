% Returns S^q next given S^(q-1) seg, edge e and image im
function [next] = seg_step(seg, e, im)
%%
vi = e(2);
vj = e(3);
compi = which_component(vi, seg);
compj = which_component(vj, seg);
%%
if compi ~= compj
    % vi and vj are in separate components
    w = e(1);
    mint = MInt(compi, compj, seg, im);
    if w <= mint
        % merge compi and compj
        mincomp = min(compi, compj);
        maxcomp = max(compi, compj);
        compsz = size(seg);
        new_comp = cell(1, 2);
        new_comp{1} = [seg{compi} seg{compj}];
        new_comp{2} = max(w, max(Int(compi, seg, im), Int(compj, seg, im)));
        next = cell(compsz(1)-1, 2);
        next(1:mincomp-1, :) = seg(1:mincomp-1, :);
        next(mincomp:maxcomp-2, :) = seg(mincomp+1:maxcomp-1, :);
        next(maxcomp-1:compsz(1)-2, :) = seg(maxcomp+1:compsz(1), :);
        next(compsz(1)-1, :) = new_comp;
        %next = {seg{1:mincomp-1, :} seg{mincomp+1:maxcomp-1, :} seg{maxcomp+1:compsz(1), :} new_comp};
    else
        next = seg;
    end
else
    next = seg;
end