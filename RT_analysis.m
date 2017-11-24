loadMR
% %% Combine exp
% l = 0;
% for e = 1:2
% for s = 1:size(m.mats_resp{e},3)
%     l = l+1;
%     m.mats_resp{3}(:,:,l) = m.mats_resp{e}(:,:,s);
%     m.mats_RT{3}(:,:,l) = m.mats_RT{e}(:,:,s);
% end
% end
% m.exp_lbls{3} = 'Both exps'
%% Clustering
loadMR
t_ord = [aBeta.trim.t_inds{:}];
clc
exp_ind = 1;
mat = m.mats_resp{3};
mat = 5-mat
disp(m.exp_lbls{exp_ind})
size(mat)
add_numbers_to_mat(nanmean(mat,3),m.f_lbls,m.t_lbls)
mat(:,8,:) = []
m.t_lbls(8) = []
%%
tcmat = [];
fcmat = [];
for s_ind = 1:size(mat,3)
   tcmat(:,:,s_ind) = corr(mat(:,:,s_ind));
   fcmat(:,:,s_ind) = corr(mat(:,:,s_ind)');
end
mtcmat = nanmean(tcmat,3); % RFX
mfcmat = nanmean(fcmat,3); % RFX
%mtcmat = corr(nanmean(mat,3)); % FFX
%mfcmat = corr(nanmean(mat,3)') % FFX
Z_t = linkage(1-get_triu(mtcmat),'ward');
Z_f = linkage(1-get_triu(mfcmat),'ward');
figure(1)
[h x perm] = dendrogram(Z_t,0,'orientation','left','labels',m.t_lbls);
make_pretty_dend(h);
figure(2)
[h x perm] = dendrogram(Z_f,0,'orientation','left','labels',m.f_lbls);
make_pretty_dend(h);
f = figure(3);
add_numbers_to_mat(nanmean(mat(perm,:,:),3),m.f_lbls(perm),m.t_lbls)
%sp.FontWeight = 'bold';
f.CurrentAxes.FontSize = 12
%% Subjective Objective tasks; 
exp_ind = 2;
mat = m.mats_resp{exp_ind}
f =figure(1)

mm = squeeze(nanmean(mat,1));
s = std(mm,[],2);
s = s-mean(s)

bar(s)
f.CurrentAxes.XTickLabel = m.t_lbls;
f.CurrentAxes.XTickLabelRotation = 45;
%%
a = squeeze(nanmean(m.mats_resp{1}));
dist = pdist(a);
dendrogram(linkage(dist,'ward'),'labels',m.t_lbls)
xtickangle(45)
%%


