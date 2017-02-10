

function [corrFun, b, success, actualTimes] = findCorrection(correctTo, correctFrom, makePlots)
% function [corrFun, b] = makeCorrection(correctTo, correctFrom, makePlots)
%
% make a function that linearly predicts correctTo from correctFrom, 
% both vectors of same length
% - attempts to find which indices of correctTo match those of correctFrom

tolerance = 0.025; % seconds, amount of difference between diffs to allow
% if these are electrical copies of the same signal, then it should be less
% than a sample on both systems. It might be more if there's variation in
% how the signal is converted from analog to digital, for instance. 
excludePct = 2; % percentage of events at start and end of sample to exclude

correctTo = correctTo(:);
correctFrom = correctFrom(:);

nF = length(correctFrom);
startInd = 1;
success = false;
nExcl = floor(excludePct/100*nF);
md = nan(1,length(correctTo)-nF);
while startInd+nF-1<=length(correctTo) && ~success
    t = correctTo(startInd:startInd+nF-1);
    f = correctFrom;
    
    if nExcl>0
        t = t(nExcl+1:end-nExcl);
        f = f(nExcl+1:end-nExcl);
    end
    
    md(startInd) = max(abs(diff(t)-diff(f)));
    if md(startInd)<tolerance
        success = true;        
        break;
    end
    startInd = startInd+1;
end

if success
    actualTimes = correctTo(startInd:startInd+nF-1);
    
    b = regress(t, [f ones(size(f))]);
    corrFun = @(f)[f(:) ones(size(f(:)))]*b;
    
    fprintf(1, 'drift rate was %.3f msec / hour\n', (b(1)-1)*60*60*1000);
else
    figure; plot(md, '.')
    b = [];
    corrFun = [];
    actualTimes = [];
end

