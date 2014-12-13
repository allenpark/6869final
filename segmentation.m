% Takes an image im and returns a list of the segments
function [seg, compmap]=segmentation(im, channel, displaying)
%%
if nargin <= 1
    channel = 0;
end
if nargin <= 2
    displaying = true;
end
G = fspecial('gaussian', [5 5], 0.8);
im = imfilter(im, G, 'same');

%%
% 0. Sort E into pi=(o_1, ..., o_m) by non-decreasing edge weight.
tic
unsorted_graph = init_graph(im);
[~, I] = sort(unsorted_graph(:, 1));
edges = unsorted_graph(I, :);
toc

%%
% 1. Start with a segmentation S_0, where each vertex v_i is in its own 
% component.
tic
sz = size(im);
m = sz(1);
n = sz(2);
compmap = 1:m*n;
num_comp = m*n;
seg = cell(m*n, 2);
for i = 1:m
    for j = 1:n
        new_comp = cell(1, 2);
        new_comp{1} = sub2ind(sz, i, j);
        new_comp{2} = 0;
        ind = sub2ind(sz, i, j);
        seg(ind, :) = new_comp;
    end
end
toc

%%
% 2. Repeat step 3 for q = 1, . . . , m.
% 3. Run seg_step on S^(q-1) to generate S^q.
tic
numstatsrecorded = 9;
stats = zeros(length(edges), numstatsrecorded);
for q = 1:length(edges)
    fprintf('Starting q=%d out of %d for channel %d\n', q, length(edges), channel);
    e = edges(q, :);
    [seg, compmap, num_comp, stat] = seg_step(seg, compmap, num_comp, e, im);
    stats(q, :) = stat;
end
[reduced_seg, reduced_compmap] = reduce_seg(seg, compmap);
toc

%%
% 4. Return S = S^m.
if displaying
    tic
    vis_seg(reduced_seg, im);
    toc
end
return
%%
count = 0;
mcount = 0;
nmcount = 0;
for i=1:length(edges)
    if stats(i, 1) ~= 0
        count = count + 1;
        if stats(i, 3) <= stats(i, 4)
            mcount = mcount + 1;
        else
            nmcount = nmcount + 1;
        end
    end
end
rstats = zeros(count, numstatsrecorded); % reduced stats
mstats = zeros(mcount, numstatsrecorded); % merged stats
nmstats = zeros(nmcount, numstatsrecorded); % not merged stats
count = 1;
mcount = 1;
nmcount = 1;
for i=1:length(edges)
    if stats(i, 1) ~= 0
        rstats(count, :) = stats(i, :);
        count = count + 1;
        if stats(i, 3) <= stats(i, 4)
            mstats(mcount, :) = stats(i, :);
            mcount = mcount + 1;
        else
            nmstats(nmcount, :) = stats(i, :);
            nmcount = nmcount + 1;
        end
    end
end
%%
figure; scatter(rstats(:, 3), rstats(:, 4));
a = axis; linehelp = [max(a(1), a(3)) min(a(2), a(4))]; line(linehelp, linehelp); title('All stats (w/mint)');
%%
figure; scatter(mstats(:, 3), mstats(:, 4));
a = axis; linehelp = [max(a(1), a(3)) min(a(2), a(4))]; line(linehelp, linehelp); title('Merged stats (w/mint)');
%%
figure; scatter(nmstats(:, 3), nmstats(:, 4));
a = axis; linehelp = [max(a(1), a(3)) min(a(2), a(4))]; line(linehelp, linehelp); title('Not merged stats (w/mint)');
%%
for i=1:length(reduced_seg)
    s = reduced_seg{i, 1};
    if size(s, 2) > 2000
        fprintf('Seg %d with size %d\n', i, size(s, 2));
    end
end    
%%
s = reduced_seg{178, 1};
x = zeros(size(im), 'uint8');
for i=1:length(s)
    [a, b] = ind2sub(size(x), s(i));
    x(a, b, :) = im(a, b, :);
end
figure; subplot(1, 2, 1); imshow(x); subplot(1, 2, 2); imshow(im);
%%
s = reduced_seg{178, 1};
compcount = 1;
compstats = double.empty(0, numstatsrecorded);
for i=1:length(rstats)
    if any(rstats(i, 1) == s) || any(rstats(i, 2) == s)
        % vi or vj is in rstats
        n = 4;
        if true||rstats(i, 4) >= 0.7 / n && rstats(i, 4) < 0.7 / (n-1)
            compstats(compcount, :) = rstats(i, :);
            compcount = compcount + 1;
        end
    end
end
figure; scatter(compstats(:, 3), compstats(:, 4));
a = axis; linehelp = [max(a(1), a(3)) min(a(2), a(4))]; line(linehelp, linehelp); title('Component stats (w/mint)');
for i=1:10
    line(linehelp, linehelp+0.7/i);
end
%%
s = reduced_seg{178, 1};
compcount = 1;
compstats = double.empty(0, numstatsrecorded);
for i=1:length(rstats)
    if any(rstats(i, 1) == s) || any(rstats(i, 2) == s)
        % vi or vj is in rstats
        n = 4;
        if true||rstats(i, 4) >= 0.7 / n && rstats(i, 4) < 0.7 / (n-1)
            compstats(compcount, :) = rstats(i, :);
            compcount = compcount + 1;
        end
    end
end
figure; scatter(compstats(:, 3), compstats(:, 4));
a = axis; linehelp = [max(a(1), a(3)) min(a(2), a(4))]; line(linehelp, linehelp); title('Component stats (w/mint)');
for i=1:10
    line(linehelp, linehelp+0.7/i);
end