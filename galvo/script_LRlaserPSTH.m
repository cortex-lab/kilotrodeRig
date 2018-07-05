
%% load 
mouseName = 'SS095'; thisDate = '2018-07-02'; tlExpNum = 7; cwExpNum = 8;

root = getRootDir(mouseName, thisDate);

sp = loadAllKsDir(mouseName, thisDate);

load(fullfile(root, 'activeData'))
    
%% galvo/laser details
 % (this should be stored somewhere so we don't have to recompute it, but
 % for now it is not)
load(dat.expFilePath(mouseName, thisDate, tlExpNum, 'Timeline', 'master'));

p = dat.paths;
load(dat.expFilePath(mouseName, thisDate, cwExpNum, 'Block', 'master'));
rig = load(fullfile(p.globalConfig, block.rigName, 'hardware.mat'));

root = getRootDir(mouseName, thisDate);
alignDir = fullfile(root, 'alignments');
bBlockToTL= readNPY(fullfile(alignDir, ...
            sprintf('correct_block_%d_to_timeline_%d.npy', cwExpNum, tlExpNum)));
        
[galvoPos, laserAmp] = findGalvoLaser(Timeline, block, rig, bBlockToTL);

    
%%

win = [-0.5 2];
timeBinSize = 0.02;

bslWin = [-0.5 0];
bslEvents = cwtA.stimOn;
depthBinSize = 20;

for probeInd = 1:2
    
f = figure; set(f, 'Name', sp(probeInd).name);
nEv=3;

ii = 1;
eventTimes = cwtA.stimOn(laserAmp<50); 
eventName = 'vis, no laser';

subplot(1,nEv+2,ii);
[timeBins, depthBins, allP, normVals2] = psthByDepth(sp(probeInd).st, sp(probeInd).spikeDepths, depthBinSize, timeBinSize, eventTimes, win, bslWin, bslEvents);
plotPSTHbyDepth(timeBins, depthBins, allP, eventName, 'norm', [])
allPnone = allP;

drawnow;

ii = 2;
eventTimes = cwtA.stimOn(laserAmp>=50 & galvoPos(:,1)<0); 
eventName = 'vis, left laser';

subplot(1,nEv+2,ii);
[timeBins, depthBins, allP, normVals2] = psthByDepth(sp(probeInd).st, sp(probeInd).spikeDepths, depthBinSize, timeBinSize, eventTimes, win, bslWin, bslEvents);
plotPSTHbyDepth(timeBins, depthBins, allP, eventName, 'norm', [])
allPleft = allP;

drawnow;


ii = 3;
eventTimes = cwtA.stimOn(laserAmp>=50 & galvoPos(:,1)>0); 
eventName = 'vis, right laser';

subplot(1,nEv+2,ii);
[timeBins, depthBins, allP, normVals2] = psthByDepth(sp(probeInd).st, sp(probeInd).spikeDepths, depthBinSize, timeBinSize, eventTimes, win, bslWin, bslEvents);
plotPSTHbyDepth(timeBins, depthBins, allP, eventName, 'norm', [])
allPright = allP;
drawnow;

subplot(1,nEv+2,nEv+1);
plotPSTHbyDepth(timeBins, depthBins, allPnone-allPleft, 'none minus left', 'norm', [])
subplot(1,nEv+2,nEv+2);
plotPSTHbyDepth(timeBins, depthBins, allPnone-allPright, 'none minus right', 'norm', [])
drawnow;
end