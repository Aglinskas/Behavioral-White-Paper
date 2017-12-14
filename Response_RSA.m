size(rm)

m = squeeze(nanmean(rm))
mm = mean(m,2);
figure(1)
Z = linkage(pdist(mm),'ward');
nclust = 3
[h clust perm] = dendrogram(Z,nclust,'labels',aBeta.t_lbls(1:10));
[h x perm] = dendrogram(Z,'labels',aBeta.t_lbls(1:10))
xtickangle(45)
figure(2)
ord = perm;bar(mm(ord));xticklabels(aBeta.t_lbls(ord));xtickangle(45)
model = zeros([size(clust,1) size(clust,1)]);
for i = unique(clust)'
    model(find(clust==i),find(clust==i)) = 1;
end
add_numbers_to_mat(model,aBeta.t_lbls(1:10))
%% Betas 
bmat = aBeta.fmat;
cmat = [];
for s = 1:size(bmat,3)
    cmat(:,:,s) = corr(bmat(:,:,s));
end
Z = linkage(1-get_triu(mean(cmat,3)),'ward')
dendrogram(Z,'labels',aBeta.t_lbls(1:10));xtickangle(45)
%% Model Evidence
clc
m = pdist(mm);
for s = 1:20
v1 = cmat(:,:,s);
v1 = get_triu(v1)';
e(s) = corr(v1(:),m');
end
[H,P,CI,STATS] = ttest(e);
tstat  = STATS.tstat
P
%% Model Null
clc
n = [];
m = model;
for i = 1:1000
m = model(Shuffle(1:size(model,1)),Shuffle(1:size(model,2)));
for s = 1:20
v1 = cmat(:,:,s);
e1(s) = corr(v1(:),m(:));
end
[H,P,CI,STATS] = ttest(e1);
n(i) = STATS.tstat;
end
disp(length(find(n >= tstat)) / length(n))
%% 
model2 = zeros(10,10);
for i = 1:5
model2(aBeta.trim.t_inds{i},aBeta.trim.t_inds{i}) = 1;
end

m = model2;
for s = 1:20
v1 = cmat(:,:,s);
e1(s) = corr(v1(:),m(:));
end
[H,P,CI,STATS] = ttest(e1);
tstat  = STATS.tstat;
[H,P,CI,STATS] = ttest(e1,e)