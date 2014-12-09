% Returns S^q next given S^(q-1) seg, edge e and image im
function [seg, compmap] = seg_step(seg, compmap, e, im)
%%
vi = e(2);
vj = e(3);
compi = which_component(vi, seg, compmap);
compj = which_component(vj, seg, compmap);
if isempty(seg{compi, 1}) || seg{compi, 2} == -1 || isempty(seg{compj, 1}) || seg{compj, 2} == -1
    error('compi %d or compj %d were empty', compi, compj);
end
%%
if compi ~= compj
    % vi and vj are in separate components
    w = e(1);
    mint = MInt(compi, compj, seg, im);
    if w <= mint
        % merge compi and compj
        if size(seg{compi, 1}, 2) > size(seg{compj, 1}, 2)
            smaller_comp = compj;
            larger_comp = compi;
        else
            smaller_comp = compi;
            larger_comp = compj;
        end
        small_list = seg{smaller_comp, 1};
        for i = 1:size(small_list, 2)
            x = small_list(i);
            compmap(x) = larger_comp;
        end
        seg{larger_comp, 1} = [seg{larger_comp, 1} seg{smaller_comp, 1}];
        if w < Int(compi, seg, im) || w < Int(compj, seg, im)
            error('w < Int(compi, seg, im) || w < Int(compj, seg, im)');
        end
        seg{larger_comp, 2} = w;
        seg{smaller_comp, 1} = [];
        seg{smaller_comp, 2} = -1;
    end
end