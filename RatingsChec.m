loadMR
fn_temp = '/Users/aidasaglinskas/Google Drive/Aidas:  Summaries & Analyses (WP 1.4)/Data_faces/S%d/S%d_ScannerMyTrials_RBLT.mat';
rm = []
for i = 1:length(subvect.face)
subID = subvect.face(i)
fn = sprintf(fn_temp,subID,subID);
myTrials = load_myTrials(fn);
myTrials = fix_myTrials(myTrials);
uf = unique({myTrials([myTrials.blockNum] < 11).word})';
for f = 1:40
for b = 1:10
    ind_bool = [myTrials.blockNum]' == b & strcmp({myTrials.word}',uf{f});
    ind = find(ind_bool);
    if length(ind) ~= 1;error('don fucked');end
rm(f,b,i) =  myTrials(ind).resp;
end
end
end
%%
%loadMR;
%mat = m.mats_resp{1};
tinds = aBeta.trim.t_inds;
for i = 1:length(tinds)
trmat(:,i,:) = mean(rm(:,tinds{i},:),2);
end
clc
mat = rm;
mat = mat;
%%
addpath('/Users/aidasaglinskas/Documents/MATLAB/anova_rm/')
ord = 1:size(mat,2);
mn = squeeze(nanmean(mat(:,ord,:),1));
%mn = squeeze(nanstd(mat,[],1))
size(mn)
sd = nanstd(mn');size(sd)
se = sd ./ sqrt(size(rm,3));
use_m = mean(mn')% - mean(mean(mn'))
use_s = sd
[Y I] = sort(use_m);
%ord = I;
use_m = use_m(ord)
clf;bar(use_m);hold on
errorbar(use_m,use_s,'r*')
xticklabels(aBeta.t_lbls(ord))
xtickangle(45)
%anova1(mn')
%anova_rm(mn')
%% t tests  
clc
albls = {aBeta.t_lbls(1:10) aBeta.trim.t_lbls};
lbls = albls{find(cellfun(@length,albls) == size(mn,1))};
pairs = nchoosek(1:size(mn,1),2);
for p = 1:length(pairs)
   thr = .05 / length(pairs);
   [H,P,CI,STATS] = ttest(mn(pairs(p,1),:)',mn(pairs(p,2),:)'); 
   tmat(i,j) = STATS.tstat;
   pmat(i,j) = P;
   
   if P < thr
       disp(sprintf('%s-%s: t(%d) = %s, p = %s',lbls{pairs(p,1)},lbls{pairs(p,2)},STATS.df,num2str(STATS.tstat,'%.2i'),num2str(P,'%.2i')))
   end
end