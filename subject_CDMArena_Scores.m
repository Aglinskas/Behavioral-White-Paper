clear all;loadMR
d = []
l = 0;
f.d = '/Users/aidasaglinskas/Downloads/fmri_words-master/Food RSA Rating/similarityJudgementData/';
f.fls = dir([f.d '*_workspace.mat']);
f.fls = {f.fls.name}'
for f_ind = 1:length(f.fls);
f.f_ind = f_ind;
f.fn = fullfile(f.d,f.fls{f.f_ind});
dist = loadnocrap(f.fn)
if ~isempty(dist)
l = l+1;
d(l,:) = dist
nms{l} = f.fls{f.f_ind};
end
end
%% Dendro
f = figure(1)
md = mean(d,1);
Z = linkage(md,'ward');
[h x perm] = dendrogram(Z,'labels',m.t_lbls)
make_pretty_dend(h)
xtickangle(45)
f.CurrentAxes.FontSize = 15
clc;disp('done')
%% CMD scale
f = figure(1);clf
arrayfun(@(x) text(c(x,1),c(x,2),m.t_lbls{x},'FontSize',14,'FontWeight','bold'),1:length(c))
th = .01;
xlim([min(c(:,1))-th max(c(:,1))+th])
ylim([min(c(:,2))-th max(c(:,2)+th)])
f.CurrentAxes.XColor = [1 1 1];
f.CurrentAxes.YColor = [1 1 1];
%% Subject similarity
cmat = []
mm = nanmean(mat,3);
m = mm(:);
for s2 = 1:size(mat,3)
for s1 = 1:size(mat,3)
a = mat(:,:,s1);
b = mat(:,:,s2);
cmat(s1,s2) = corr(a(:),b(:),'rows','pairwise');
end
end
%%
cmat = [];
for s = 1:size(mat,3)
    a = mat(:,:,s);
    cmat(s) = corr(a(:),m,'rows','pairwise');
end


