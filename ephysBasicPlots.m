

% Basic plots to characterize a recording

% - Driftmap: spikes over time by colored by amplitude
% - Waveform CDFs: distributions of spike waveforms by amplitude
% - Unit scatter: as in sfn2016 poster
% - AP RMS by depths
% - LFP power: spectrum by depth
% - event-locked MUA histograms: any events that can be automatically/easily
% detected, plot responses of MUA aligned to these events

%% 
ksDir = '/Users/nick/data/Cori/2016-12-18/ephys_V1';
rawDir = '';
lfpFilename = '';

%% load and compute basics
sp = loadKSdir(fullfile(dataRoot, 'ephys_AM'));

[spikeAmps, spikeDepths, templateYpos, tempAmps, tempsUnW, tempDur, tempPeakWF] = ...
    templatePositionsAmplitudes(sp.temps, sp.winv, sp.ycoords, sp.spikeTemplates, sp.tempScalingAmps);

if isfield(sp, 'gain')
    spikeAmps = spikeAmps*sp.gain;
    tempAmps = tempAmps*sp.gain;
end

sp.spikeAmps = spikeAmps;
sp.spikeDepths = spikeDepths;
sp.templateYpos = templateYpos;
sp.tempAmps = tempAmps;
sp.tempsUnW = tempsUnW;
sp.tempDur = tempDur;
sp.tempPeakWF = tempPeakWF;

%% driftmap

sa = sp.spikeAmps;
sd = sp.spikeDepths;
st = sp.st;

inclSpikes = sa>50;
plotDriftmap(st(inclSpikes), sa(inclSpikes), sd(inclSpikes))

% save the global one, but also zoom in to segments

%% waveform cdfs

depthBins = 0:40:3840;
ampBins = 0:30:min(max(spikeAmps),800); % µV?
recordingDur = sp.st(end);

[pdfs, cdfs] = computeWFampsOverDepth(spikeAmps, spikeDepths, ampBins, depthBins, recordingDur);
plotWFampCDFs(pdfs, cdfs, ampBins, depthBins);

%% another version of waveform amplitudes across depth


depthBins = 0:80:3840; % for this one use coarser bins
ampBins = 0:30:min(max(spikeAmps),800); % µV?
recordingDur = sp.st(end);

[pdfs, cdfs] = computeWFampsOverDepth(spikeAmps, spikeDepths, ampBins, depthBins, recordingDur);
%%
figure;
colors = hsv(length(ampBins)-1);
for q = 3:length(ampBins)-1
    plot(cdfs(:,q), depthBins(1:end-1), 'Color', colors(q,:)); hold on;
end
set(gca, 'Color', 'k');
xlabel('firing rate (sp/s)');
ylabel('depth on probe (µm)');
h = legend(array2stringCell(ampBins(3:end-1)));
set(h, 'TextColor', 'w');

makepretty;

%% compute RMS over probe
gainFactor = sp.gain;
[rmsPerChannelV, madPerChannelV] = computeRawRMS('j:\Eijkman\2016-05-21\visctx', gainFactor);

%% plot RMS

xc = sp.xcoords; yc = sp.ycoords;

figure;
plotAsPhase3(rmsPerChannelV, xc, yc);
colormap hot
caxis([7 30]);
colorbar

%% compute LFP power

lfpFs = 2500;
nChansInFile = 385;

freqBand = [];

[lfpByChannel, allPowerEst, F, allPowerVar] = lfpBandPower(lfpFilename, lfpFs, nChansInFile, freqBand);

chanMap = readNPY(fullfile(ksDir, 'channel_map.npy'));
nC = length(chanMap);

allPowerEst = allPowerEst(:,chanMap+1)'; % now nChans x nFreq



%% plot LFP power
dispRange = [0 100]; % Hz
marginalChans = [10:50:nC];
freqBands = {[1.5 4], [4 10], [10 30], [30 80], [80 200]};


plotLFPpower(F, allPowerEst, dispRange, marginalChans, freqBands);


