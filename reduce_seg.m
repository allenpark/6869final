% Takes a segmentation and reduces it
function [reduced, compmap]=reduce_seg(seg, compmap)
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
map = zeros(size(seg_list, 1), 1);
for i=1:size(seg_list, 1)
    if ~isempty(seg_list{i})
        reduced(current, :) = seg(i, :);
        map(i) = current;
        current = current + 1;
    end
end

for i=1:length(compmap)
    compmap(i) = map(compmap(i));
end