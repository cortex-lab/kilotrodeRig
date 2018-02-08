
function [galvoIntervals, galvoAPLR, laserIntervals, laserPower] = extractGalvo(...
    mouseName, thisDate, tlExpNum, galvoExpNum)
%function [galvoIntervals, galvoAPLR, laserIntervals, laserPower] = extractGalvo(...
%    mouseName, thisDate, tlExpNum, galvoExpNum)
%
% Find the intervals when the galvo was positioned at each location (mm). Find
% the times when the laser was turned on, and at what power (mW). 

%% load things
load(dat.expFilePath(mouseName, thisDate, tlExpNum, 'Timeline', 'master'));

p = dat.paths;
load(dat.expFilePath(mouseName, thisDate, galvoExpNum, 'Block', 'master'));
rig = load(fullfile(p.globalConfig, block.rigName, 'hardware.mat'));
load(dat.expFilePath(mouseName, thisDate, galvoExpNum, 'parameters', 'master'));

mWperV = parameters.mWperV;

s = rig.daqController.SignalGenerators;
n = rig.daqController.ChannelNames;

mmPerVx = s(strcmp(n, 'galvoX')).Scale; 
mmPerVy = s(strcmp(n, 'galvoY')).Scale;

tt = Timeline.rawDAQTimestamps; Fs = Timeline.hw.daqSampleRate;
gx = Timeline.rawDAQData(:, strcmp({Timeline.hw.inputs.name}, 'galvoX'));
gy = Timeline.rawDAQData(:, strcmp({Timeline.hw.inputs.name}, 'galvoY'));
las = Timeline.rawDAQData(:, strcmp({Timeline.hw.inputs.name}, 'waveOutput'));

gxMM = gx/mmPerVx;
gyMM = gy/mmPerVy;
lasmW = (las-0.12)*mWperV;

%% detect galvo things

gxMMChange = abs(conv(diff(medfilt1(gxMM,6)),myGaussWin(0.002, Fs), 'same'));
gyMMChange = abs(conv(diff(medfilt1(gyMM,6)),myGaussWin(0.002, Fs), 'same'));
totalChange = (gxMMChange.^2+gyMMChange.^2).^0.5;
minHeight = max(totalChange(tt<10 & tt>1))*3; % three times the highest height achieved in first 10 sec, during which we assume the galvos were stable
[pks, locs] = findpeaks(totalChange, Fs, 'MinPeakHeight', minHeight);

galvoIntervals = [0 locs(1); locs(1:end-1) locs(2:end); locs(end) max(tt)];
galvoAPLR = zeros(size(galvoIntervals));
midIntSamp = round(mean(galvoIntervals,2)*Fs);
galvoAPLR(:,1) = gyMM(midIntSamp);
galvoAPLR(:,2) = gxMM(midIntSamp);


%% now laser detection
bslMean = mean(lasmW(tt<10 & tt>1)); bslStd = std(lasmW(tt<10 & tt>1));
thresh = bslMean+[7*bslStd 10*bslStd];
[~, lasOn, lasDown] = schmittTimes(tt, lasmW, thresh);
% laser amp is the max amplitude in the short period following laser onset
lasSamps = bsxfun(@plus, round(lasOn*Fs), round([0:0.001:0.02]*Fs));
lasAmpSamps = lasmW(lasSamps);
lasAmp = max(lasAmpSamps,[], 2);

lasDur = lasDown-lasOn;
excl = lasAmp<min(parameters.laserAmp(parameters.laserAmp>0))/2 | lasDur<min(parameters.laserDuration)/2;
lasOn = lasOn(~excl); lasDown = lasDown(~excl);

laserPower = lasAmp(~excl);
laserIntervals = [lasOn lasDown];

%%
return;

%% test plots

figure; plot(tt, gyMM)
hold on; plot(galvoIntervals(:,1), galvoAPLR(:,1), 'o')
hold on; plot(galvoIntervals(:,2), galvoAPLR(:,1), 'o')

figure; plot(tt, gxMM)
hold on; plot(galvoIntervals(:,1), galvoAPLR(:,2), 'o')
hold on; plot(galvoIntervals(:,2), galvoAPLR(:,2), 'o')

figure; plot(tt(1:end-1), totalChange)
hold on; plot(locs, pks, '.')
hold on; plot([min(tt) max(tt)], minHeight*[1 1], 'k--')

