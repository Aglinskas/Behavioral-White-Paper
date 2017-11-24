function estimate_dissimMat_ltv_MA = loadnocrap(fn)

load(fn);
a(1) = strcmp(stimuli(1).name,'Memoria remota?');
a(2) = strcmp(stimuli(9).name,'Volto distintivo?');
a(3) = length(stimuli)==10;
a(4) = exist('estimate_dissimMat_ltv_MA');
if ~all(a);
    estimate_dissimMat_ltv_MA = [];
end
   
    

