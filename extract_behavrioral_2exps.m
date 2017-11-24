clear;loadMR;
m = struct;
for exp_ind = 1:2; % experiment index, 1 = faces, 2 = words
fn.temp{1} = '/Users/aidasaglinskas/Google Drive/Aidas:  Summaries & Analyses (WP 1.4)/Data_faces/S%d/S%d_ScannerMyTrials_RBLT.mat';
fn.temp{2} = '/Users/aidasaglinskas/Google Drive/Aidas:  Summaries & Analyses (WP 1.4)/Data_words/S%d/wS%d_Results.mat';
subvs = {7:31 1:31};
subv = subvs{exp_ind};%7:31;
temp = struct;
for s_ind = 1:length(subv);
subID = subv(s_ind);
fn.fn = sprintf(fn.temp{exp_ind},subID,subID);
myTrials = load_myTrials(fn.fn);
myTrials = fix_myTrials(myTrials);
if s_ind==1;unique_faces = unique({myTrials(ismember([myTrials.blockNum],1:10)).word});end
for f = 1:40
for b = 1:10
ind = [myTrials.blockNum] == b & strcmp({myTrials.word},unique_faces{f});
ind = find(ind);
if length(ind) ~= 1; error('ind error');end
temp.RT(f,b,s_ind) = myTrials(ind).RT;
temp.resp(f,b,s_ind) = myTrials(ind).resp;
end
end
end
m.mats_resp{exp_ind} = temp.resp;
m.mats_RT{exp_ind} = temp.RT;
end
m.f_lbls = unique_faces';
m.t_lbls = aBeta.t_lbls(1:10);
m.exp_lbls = {'Face Data','Word Data'};
disp('done')
save('behavioral_mats.mat','m')
%%
disp('Dropping lazy subjects')
loadMR
%m.mats_resp{2}(:,:,1:7) = [];
%m.mats_resp{1}(:,:,16) = [];
thresh = 20; % 5% percent skippend answers
in = [];
for exp_ind = 1:2
for s_ind = 1:size(m.mats_resp{exp_ind},3)
bm = m.mats_resp{exp_ind}(:,:,s_ind);
in(s_ind) = sum(isnan(bm(:)));
end
%bar(in);
%xticks(1:size(m.mats_resp{exp_ind},3))
%title({m.exp_lbls{exp_ind} 'Nans'},'fontsize',20)
m.mats_resp{exp_ind}(:,:,find(in > thresh)) = [];
m.mats_RT{exp_ind}(:,:,find(in > thresh)) = [];
disp(find(in > thresh))
end
save('behavioral_mats.mat','m')
%%