% Takes a segmentation and reduces it
function [reduced]=reduce_seg(seg)
%%
seg_list = seg(:, 1);
count = 0;
for i=1:size(seg_list, 1)
    if ~isempty(seg_list{i})
        count = count + 1;
    end
end
reduced = cell(count, 2);
current = 1;
for i=1:size(seg_list, 1)
    if ~isempty(seg_list{i})
        reduced(current, :) = seg(i, :);
        current = current + 1;
    end
end
