
function psths = activePSTHs2(sp, cwtA, cweA, rootFigDir)

nEv = 5;
%%

eventTimes = cwtA.stimOn; eventName = 'stimOnset';

win = [-0.5 1.5];
timeBinSize = 0.02;

bslWin = [-0.5 0];
depthBinSize = 20;

subplot(2,nEv,1);
[timeBins, depthBins, allP, normVals] = psthByDepth(sp.st, sp.spikeDepths, depthBinSize, timeBinSize, eventTimes, win, bslWin);
plotPSTHbyDepth(timeBins, depthBins, allP, eventName, 'norm', [])

subplot(2,nEv,nEv+1);
plotPSTHbyDepth(timeBins, depthBins, allP, eventName, 'norm', []) % for the first event, normalization is the same
drawnow;

psths(1).name = eventName;
psths(1).timeBins = timeBins;
psths(1).depthBins = depthBins;
psths(1).allP = allP; 
psths(1).normP = allP;

%%

eventTimes = cwtA.earlyMove(~isnan(cwtA.earlyMove)); eventName = 'moveOnset';

win = [-0.5 1.5];
timeBinSize = 0.02;

bslWin = [-0.5 -0.2];
depthBinSize = 20;

subplot(2,nEv,2);
[timeBins, depthBins, allP, normVals2] = psthByDepth(sp.st, sp.spikeDepths, depthBinSize, timeBinSize, eventTimes, win, bslWin);
plotPSTHbyDepth(timeBins, depthBins, allP, eventName, 'norm', [])

subplot(2,nEv,nEv+2);
% un-normalized relative to those norm vals, then re-normalize relative to
% the stimOn ones
unnormP = bsxfun(@plus, bsxfun(@times, allP, normVals2(:,2)), normVals2(:,1));
renormP = bsxfun(@rdivide, bsxfun(@minus, unnormP, normVals(:,1)), normVals(:,2));
renormP(isnan(renormP)) = 0;
plotPSTHbyDepth(timeBins, depthBins, renormP, eventName, 'norm', [])

ii = 2;
psths(ii).name = eventName;
psths(ii).timeBins = timeBins;
psths(ii).depthBins = depthBins;
psths(ii).allP = allP; 
psths(ii).normP = renormP;

%%

eventTimes = cwtA.beeps; eventName = 'goCue';

win = [-0.5 1.5];
timeBinSize = 0.02;

bslWin = [-0.5 0];
bslEvents = eventTimes;
depthBinSize = 20;

subplot(2,nEv,3);
[timeBins, depthBins, allP, normVals2] = psthByDepth(sp.st, sp.spikeDepths, depthBinSize, timeBinSize, eventTimes, win, bslWin, bslEvents);
plotPSTHbyDepth(timeBins, depthBins, allP, eventName, 'norm', [])

subplot(2,nEv,nEv+3);
% un-normalized relative to those norm vals, then re-normalize relative to
% the stimOn ones
unnormP = bsxfun(@plus, bsxfun(@times, allP, normVals2(:,2)), normVals2(:,1));
renormP = bsxfun(@rdivide, bsxfun(@minus, unnormP, normVals(:,1)), normVals(:,2));
renormP(isnan(renormP)) = 0;
plotPSTHbyDepth(timeBins, depthBins, renormP, eventName, 'norm', [])

drawnow;

ii = 3;
psths(ii).name = eventName;
psths(ii).timeBins = timeBins;
psths(ii).depthBins = depthBins;
psths(ii).allP = allP; 
psths(ii).normP = renormP;

%%

eventTimes = cwtA.feedbackTime(cweA.feedback==1); eventName = 'reward';

win = [-0.5 1.5];
timeBinSize = 0.02;

bslWin = [-0.5 0];
depthBinSize = 20;

subplot(2,nEv,4);
[timeBins, depthBins, allP, normVals2] = psthByDepth(sp.st, sp.spikeDepths, depthBinSize, timeBinSize, eventTimes, win, bslWin);
plotPSTHbyDepth(timeBins, depthBins, allP, eventName, 'norm', [])

subplot(2,nEv,nEv+4);
% un-normalized relative to those norm vals, then re-normalize relative to
% the stimOn ones
unnormP = bsxfun(@plus, bsxfun(@times, allP, normVals2(:,2)), normVals2(:,1));
renormP = bsxfun(@rdivide, bsxfun(@minus, unnormP, normVals(:,1)), normVals(:,2));
renormP(isnan(renormP)) = 0;
plotPSTHbyDepth(timeBins, depthBins, renormP, eventName, 'norm', [])

drawnow;

ii = 4;
psths(ii).name = eventName;
psths(ii).timeBins = timeBins;
psths(ii).depthBins = depthBins;
psths(ii).allP = allP; 
psths(ii).normP = renormP;

%%

eventTimes = cwtA.feedbackTime(cweA.feedback==-1); eventName = 'negFeedback';

win = [-0.5 1.5];
timeBinSize = 0.02;

bslWin = [-0.5 0];
depthBinSize = 20;

subplot(2,nEv,5);
[timeBins, depthBins, allP] = psthByDepth(sp.st, sp.spikeDepths, depthBinSize, timeBinSize, eventTimes, win, bslWin);
plotPSTHbyDepth(timeBins, depthBins, allP, eventName, 'norm', [])

subplot(2,nEv,nEv+5);
% un-normalized relative to those norm vals, then re-normalize relative to
% the stimOn ones
unnormP = bsxfun(@plus, bsxfun(@times, allP, normVals2(:,2)), normVals2(:,1));
renormP = bsxfun(@rdivide, bsxfun(@minus, unnormP, normVals(:,1)), normVals(:,2));
renormP(isnan(renormP)) = 0;
plotPSTHbyDepth(timeBins, depthBins, renormP, eventName, 'norm', [])

drawnow;

ii = 5;
psths(ii).name = eventName;
psths(ii).timeBins = timeBins;
psths(ii).depthBins = depthBins;
psths(ii).allP = allP; 
psths(ii).normP = renormP;

return

%%
clear r;
n = 0; 
n = n+1; r(n).mouseName = 'Cori'; r(n).thisDate = '2016-12-14'; r(n).tlExpNum = 1; r(n).cwExpNum = 2; r(n).passiveExpNum = 4; 
n = n+1; r(n).mouseName = 'Cori'; r(n).thisDate = '2016-12-15'; r(n).tlExpNum = 1; r(n).cwExpNum = 2; r(n).passiveExpNum = 5; 
n = n+1; r(n).mouseName = 'Cori'; r(n).thisDate = '2016-12-16'; r(n).tlExpNum = 1; r(n).cwExpNum = 2; r(n).passiveExpNum = 4; 
n = n+1; r(n).mouseName = 'Cori'; r(n).thisDate = '2016-12-17'; r(n).tlExpNum = 1; r(n).cwExpNum = 2; r(n).passiveExpNum = 4; 
n = n+1; r(n).mouseName = 'Cori'; r(n).thisDate = '2016-12-18'; r(n).tlExpNum = 1; r(n).cwExpNum = 2; r(n).passiveExpNum = 4; 
% 
n = n+1; r(n).mouseName = 'Radnitz'; r(n).thisDate = '2017-01-08'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = 5; 
n = n+1; r(n).mouseName = 'Radnitz'; r(n).thisDate = '2017-01-09'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = 5; 
n = n+1; r(n).mouseName = 'Radnitz'; r(n).thisDate = '2017-01-10'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = 5; 
n = n+1; r(n).mouseName = 'Radnitz'; r(n).thisDate = '2017-01-11'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = 5; 
n = n+1; r(n).mouseName = 'Radnitz'; r(n).thisDate = '2017-01-12'; r(n).tlExpNum = 1; r(n).cwExpNum = 2; r(n).passiveExpNum = 4; 
n = n+1; r(n).mouseName = 'Radnitz'; r(n).thisDate = '2017-01-13'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = []; 
% 
n = n+1; r(n).mouseName = 'Muller'; r(n).thisDate = '2017-01-07'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = 5; 
n = n+1; r(n).mouseName = 'Muller'; r(n).thisDate = '2017-01-08'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = 5; 
n = n+1; r(n).mouseName = 'Muller'; r(n).thisDate = '2017-01-09'; r(n).tlExpNum = 3; r(n).cwExpNum = 4; r(n).passiveExpNum = 6; 
n = n+1; r(n).mouseName = 'Muller'; r(n).thisDate = '2017-01-10'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = 5; 
n = n+1; r(n).mouseName = 'Muller'; r(n).thisDate = '2017-01-11'; r(n).tlExpNum = 1; r(n).cwExpNum = 2; r(n).passiveExpNum = 4; 
n = n+1; r(n).mouseName = 'Muller'; r(n).thisDate = '2017-01-12'; r(n).tlExpNum = 3; r(n).cwExpNum = 4; r(n).passiveExpNum = 6; 

%%
clear all;
n = 0;

n = n+1; r(n).mouseName = 'Moniz'; r(n).thisDate = '2017-05-13'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = 5; 
n = n+1; r(n).mouseName = 'Moniz'; r(n).thisDate = '2017-05-14'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = 5; 
n = n+1; r(n).mouseName = 'Moniz'; r(n).thisDate = '2017-05-15'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = 5; 
n = n+1; r(n).mouseName = 'Moniz'; r(n).thisDate = '2017-05-16'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = 5; 
n = n+1; r(n).mouseName = 'Moniz'; r(n).thisDate = '2017-05-17'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = 5; 
n = n+1; r(n).mouseName = 'Moniz'; r(n).thisDate = '2017-05-18'; r(n).tlExpNum = 1; r(n).cwExpNum = 2; r(n).passiveExpNum = 4; 
n = n+1; r(n).mouseName = 'Moniz'; r(n).thisDate = '2017-05-19'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = 5; 

%%
clear r;
n = 0; 
n = n+1; r(n).mouseName = 'Lederberg'; r(n).thisDate = '2017-12-05'; r(n).tlExpNum = 1; r(n).cwExpNum = 2; r(n).passiveExpNum = 4; 


%%

addpath('F:\Dropbox\ucl\code\analysisScripts\');

% saveDataDir = 'F:\Dropbox\ucl\data\dataSlides\CoriMullerRadnitz';
saveDataDir = '';

for n = 1:length(r)
    fn = fieldnames(r); for f = 1:length(fn); eval([fn{f} ' = r(n).(fn{f});']); end;
    fprintf(1, '%s - %s\n', mouseName, thisDate);
    try
%         ksRoot = fullfile('\\basket.cortexlab.net\data\nick', mouseName, thisDate);
%         rootFigDir = fullfile(ksRoot, 'figs');
        

        rootFigDir = getFigDir(mouseName, thisDate, 'root');
        

        rootE = dat.expPath(mouseName, thisDate, 1, 'main', 'master');
        root = fileparts(rootE);

        fprintf(1, 'loading spikes\n');
        sp = loadAllKsDir(mouseName, thisDate);

        fprintf(1, 'loading active\n');
        load(fullfile(root, 'activeData'))

        for q = 1:length(sp)
            f = figure; p = get(f, 'Position');
            set(f, 'Position', [ p(1) p(2)  1848        1015])
            set(f, 'Name', sprintf('%s - %s - %s', mouseName, thisDate, sp(q).name));
            psths = activePSTHs2(sp(q), cwtA, cweA, rootFigDir);
            saveFig(f, fullfile(rootFigDir, sprintf('psthByDepth_%s', sp(q).name)), 'jpg');
            
            if ~isempty(saveDataDir)
                spikesFn = sprintf('%s_%s_%s_spikes.mat', mouseName, thisDate, sp(q).name);
                psthsFn = sprintf('%s_%s_%s_psths.mat', mouseName, thisDate, sp(q).name);
                behavFn = sprintf('%s_%s_%s_behav.mat', mouseName, thisDate, sp(q).name);
            
                % zero out the things about spikes I don't want to keep
                s = sp(q);
                s.tempsUnW = [];
                s.tempScalingAmps = [];
                save(spikesFn, 's');
                
                save(fullfile(saveDataDir, spikesFn), 's');
                save(fullfile(saveDataDir, behavFn), 'cwtA', 'cweA');
                save(fullfile(saveDataDir, psthsFn), 'psths');
            end
%             close all
        end
    catch me
        disp(me)
    end
    
end

