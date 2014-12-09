% Returns S^q next given S^(q-1) seg, edge e and image im
function [seg, compmap, num_comp, stat] = seg_step(seg, compmap, num_comp, e, im)
%%
vi = e(2);
vj = e(3);
compi = which_component(vi, seg, compmap);
compj = which_component(vj, seg, compmap);
if isempty(seg{compi, 1}) || seg{compi, 2} == -1 || isempty(seg{compj, 1}) || seg{compj, 2} == -1
    error('compi %d or compj %d were empty', compi, compj);
end
stat = [0 0 0 0 0 0 0 0];
%%
if compi ~= compj
    % vi and vj are in separate components
    w = e(1);
    mint = MInt(compi, compj, num_comp, seg, im);
    stat = [vi vj w mint Int(compi, seg, im) Int(compj, seg, im) length(seg{compi, 1}) length(seg{compj, 1})];
    if size(seg{compi, 1}, 2) > size(seg{compj, 1}, 2)
        smaller_comp = compj;
        larger_comp = compi;
    else
        smaller_comp = compi;
        larger_comp = compj;
    end
    if w <= mint || (false && size(seg{larger_comp, 1}, 2) / size(seg{smaller_comp, 1}, 2) >= 3 && abs(Int(smaller_comp, seg, im) - w) < 10)
        % merge compi and compj
        small_list = seg{smaller_comp, 1};
        for i = 1:size(small_list, 2)
            x = small_list(i);
            compmap(x) = larger_comp;
        end
        seg{larger_comp, 1} = [seg{larger_comp, 1} seg{smaller_comp, 1}];
        if w < Int(compi, seg, im) || w < Int(compj, seg, im)
            error('w < Int(compi, seg, im) || w < Int(compj, seg, im)');
        end
        if w <= mint
            seg{larger_comp, 2} = w;
        end
        seg{smaller_comp, 1} = [];
        seg{smaller_comp, 2} = -1;
        num_comp = num_comp - 1;
    end
end