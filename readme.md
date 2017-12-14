# Model Based RSA (network taxonomy hypotheses)
Below, models for different hypotheses. 
Last model, as a control, is all regions simply paired, no larger structure.

models to test: 
where does ATFP go 
where does IFG go,
OFC associated with DMN in any way?

where amygdala go?
%%


1. core-IFG-OFC vs Core: externalised congition test. ATFP = [] amy = DMN
2. 



![](https://d2mxuefqeaa7sj.cloudfront.net/s_2A4FCA71A923BB43A2011972B3E2465E9BB227077A96F3598F1BB7C3365D74DA_1512672782719_07-Dec-2017+195202.png)
![](https://d2mxuefqeaa7sj.cloudfront.net/s_2A4FCA71A923BB43A2011972B3E2465E9BB227077A96F3598F1BB7C3365D74DA_1512672782724_07-Dec-2017+195206.png)
![](https://d2mxuefqeaa7sj.cloudfront.net/s_2A4FCA71A923BB43A2011972B3E2465E9BB227077A96F3598F1BB7C3365D74DA_1512672782729_07-Dec-2017+195209.png)

![](https://d2mxuefqeaa7sj.cloudfront.net/s_2A4FCA71A923BB43A2011972B3E2465E9BB227077A96F3598F1BB7C3365D74DA_1512672782737_07-Dec-2017+195215.png)
![](https://d2mxuefqeaa7sj.cloudfront.net/s_2A4FCA71A923BB43A2011972B3E2465E9BB227077A96F3598F1BB7C3365D74DA_1512672782750_07-Dec-2017+195219.png)
![](https://d2mxuefqeaa7sj.cloudfront.net/s_2A4FCA71A923BB43A2011972B3E2465E9BB227077A96F3598F1BB7C3365D74DA_1512672782757_07-Dec-2017+195223.png)


I correlate the model matrix with data per subject (that gives me a vector ***e*** **that is ***nsubs*** long). 
I ttest that against 0 and plot the t value below.


![](https://d2mxuefqeaa7sj.cloudfront.net/s_2A4FCA71A923BB43A2011972B3E2465E9BB227077A96F3598F1BB7C3365D74DA_1512673799552_image.png)


Comparing models, **Core/DMN/Ext** model is a better fit then **Core/Ext.** 
BUT ****
All paired model wins over all the others. Maybe we need to account for model complexity? 


Code is straight forward: 

    #%% fit model
    for j = 1:length(models) #% loop through models
    model = models{j}; % take one model
    e = []; #% let's call this 'model evidence' 'cause it sounds cool
    #%cmat is a ROIxROIxSUBJECT correlation matrix;
    for i = 1:20 #% loop through subs
    e(i) = corr(get_triu(model)',get_triu(cmat(:,:,i))'); #% upper triu of model correlated with upper triu of subjects similarity matrix;
    end
    [H,P,CI,STATS] = ttest(e); #% ttest model evidence across subjects;
    ee(j) = STATS.tstat; #% collect t values for all models
    end #% loop models 

Min Max fit values

- Added a random model (randomly split regions into 2 groups), 
- added a max model, Core-Frontal/DMN/Amy-FP’ that has clustering determined by the data; 

Plotted are mean model-data correlations, error bars represent *SE* across subjects

![](https://d2mxuefqeaa7sj.cloudfront.net/s_2A4FCA71A923BB43A2011972B3E2465E9BB227077A96F3598F1BB7C3365D74DA_1513085055127_Screen+Shot+2017-12-12+at+14.24.09.png)

----------
![](https://d2mxuefqeaa7sj.cloudfront.net/s_2A4FCA71A923BB43A2011972B3E2465E9BB227077A96F3598F1BB7C3365D74DA_1513246891997_image.png)



# netRSA Hypotheses: 
## Hypothesis 1

Do regions involved in internalised cognition (DMN) go together with regions involved in externalised cognition (IFG, OFC)? 

![](https://d2mxuefqeaa7sj.cloudfront.net/s_2A4FCA71A923BB43A2011972B3E2465E9BB227077A96F3598F1BB7C3365D74DA_1513181194832_Screen+Shot+2017-12-13+at+17.06.26.png)
![](https://d2mxuefqeaa7sj.cloudfront.net/s_2A4FCA71A923BB43A2011972B3E2465E9BB227077A96F3598F1BB7C3365D74DA_1513181196585_Screen+Shot+2017-12-13+at+17.05.31.png)
![](https://d2mxuefqeaa7sj.cloudfront.net/s_2A4FCA71A923BB43A2011972B3E2465E9BB227077A96F3598F1BB7C3365D74DA_1513180969409_Screen+Shot+2017-12-13+at+17.02.42.png)


Difference between models: t(19)=3.05, p=0.007

Answer: externalised cognition regions coordinate more closely with core, than internalised cognition network. 

 Given this..

##  Hypothesis 2

 Is the ATFP closer to core+externalised cog or internalised cog subnetworks? 

![](https://d2mxuefqeaa7sj.cloudfront.net/s_2A4FCA71A923BB43A2011972B3E2465E9BB227077A96F3598F1BB7C3365D74DA_1513248151665_Screen+Shot+2017-12-14+at+11.41.52.png)
![](https://d2mxuefqeaa7sj.cloudfront.net/s_2A4FCA71A923BB43A2011972B3E2465E9BB227077A96F3598F1BB7C3365D74DA_1513248143141_Screen+Shot+2017-12-14+at+11.42.00.png)
![](https://d2mxuefqeaa7sj.cloudfront.net/s_2A4FCA71A923BB43A2011972B3E2465E9BB227077A96F3598F1BB7C3365D74DA_1513248199747_Screen+Shot+2017-12-14+at+11.43.10.png)


answer: No difference between models: t(19)=0.86, p=0.42

Given that the ATFP goes no closer to core-externalized than internalized, does this mean is provided a unique contribution (aka, separate cluster?)

##  Hypothesis 3. ATFP as a unique cluster:


![](https://d2mxuefqeaa7sj.cloudfront.net/s_2A4FCA71A923BB43A2011972B3E2465E9BB227077A96F3598F1BB7C3365D74DA_1513248151665_Screen+Shot+2017-12-14+at+11.41.52.png)
![](https://d2mxuefqeaa7sj.cloudfront.net/s_2A4FCA71A923BB43A2011972B3E2465E9BB227077A96F3598F1BB7C3365D74DA_1513248143141_Screen+Shot+2017-12-14+at+11.42.00.png)
![](https://d2mxuefqeaa7sj.cloudfront.net/s_2A4FCA71A923BB43A2011972B3E2465E9BB227077A96F3598F1BB7C3365D74DA_1513248492200_Screen+Shot+2017-12-14+at+11.48.05.png)

![](https://d2mxuefqeaa7sj.cloudfront.net/s_2A4FCA71A923BB43A2011972B3E2465E9BB227077A96F3598F1BB7C3365D74DA_1513248509137_Screen+Shot+2017-12-14+at+11.48.22.png)


modeling ATFP as a separate cluster outperforms core-ext / Int-cog-ATFP model: t(19)=2.55, p=0.02
and core-ext-cog-ATFP / int-Cog model: t(19)=3.06, p=0.006


----------
[x] could you quickly run the same analysis for the amygdala (dropping atfp for that)


![](https://d2mxuefqeaa7sj.cloudfront.net/s_2A4FCA71A923BB43A2011972B3E2465E9BB227077A96F3598F1BB7C3365D74DA_1513257933692_Screen+Shot+2017-12-14+at+14.25.08.png)


t(19)=3.15, p=0.005



[x] send me a screen shot of the FC from neurosynth for latOFC and IFG


![](https://d2mxuefqeaa7sj.cloudfront.net/s_2A4FCA71A923BB43A2011972B3E2465E9BB227077A96F3598F1BB7C3365D74DA_1513258527655_pasted_image_at_2017_12_14_02_33_pm.png)
![](https://d2mxuefqeaa7sj.cloudfront.net/s_2A4FCA71A923BB43A2011972B3E2465E9BB227077A96F3598F1BB7C3365D74DA_1513258527668_pasted_image_at_2017_12_14_02_34_pm.png)

[x] and just try a straight t-test between atfp and the average or correlation with core and extended
    clc;size(cmat);
    targ_inds = {};
    targ_inds{1} = [ 9    10    13    14    19    20   15    16    11    12 ];
    targ_inds{2} = [ 3     4     7     8    17    18    21     5     6];
     
    v1 = cmat([1 2],targ_inds{1},:);
    v1 = squeeze(mean(mean(v1,1),2));
     
    v2 = cmat([1 2],targ_inds{2},:);
    v2 = squeeze(mean(mean(v2,1),2));
     
    [H,P,CI,STATS] = ttest(v1,v2);
    disp(sprintf('t(%d)=%s, p=%s',STATS.df,num2str(STATS.tstat,3),num2str(P,.2)))

t(19)=-0.767, p=0.5



