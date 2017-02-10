

% Basic plots to characterize a recording

% - Driftmap: spikes over time by colored by amplitude
% - Waveform CDFs: distributions of spike waveforms by amplitude
% - Unit scatter: as in sfn2016 poster
% - AP RMS by depths
% - LFP power: spectrum by depth
% - event-locked MUA histograms: any events that can be automatically/easily
% detected, plot responses of MUA aligned to these events

% TODO
% - add unit scatter
% - add wheel velocity subplot to driftmaps


%% 

clear all; close all;

%% parameters
maxPlotDriftmap = 500000;

%%

% mouseName = 'Cori'; 
% thisDate = '2016-12-18';
% tag = 'V1';

% mouseName = 'Noam'; 
% thisDate = '2016-12-11';
% tag = 'SC'; % V1, SC
% thisDate = '2016-12-07';
% tag = 'V1'; % V1, SC

% mouseName = 'SS074'; 
% thisDate = '2017-01-04';
% tag = 'SC'; % V1, SC
% thisDate = '2017-01-05';
% tag = 'SC'; % V1, SC

% mouseName = 'Muller'; 
% thisDate = '2017-01-07';
% tag = 'M2'; % V1, M2
% thisDate = '2017-01-08';
% tag = 'M2'; % AM, M2
% thisDate = '2017-01-09';
% tag = 'PM'; % PM, LM

% mouseName = 'Radnitz'; 
% thisDate = '2017-01-08';
% tag = 'M2'; %V1, M2

% mouseName = 'Houssay'; 
% thisDate = '2017-01-14';
% tag = [];

% mouseName = 'Gasser'; 
% thisDate = '2017-01-15';
% tag = [];

mouseName = 'Fleming'; 
thisDate = '2017-01-15';
tag = [];

expPath = dat.expPath(mouseName, thisDate, 1, 'main', 'master');
expRoot = fileparts(expPath);

if ~exist('tag') || isempty(tag)
    subFolder = 'ephys';
else
    subFolder = ['ephys_' tag];
end
    
    
ksDir = fullfile('\\basket.cortexlab.net\data\nick\', mouseName, thisDate, subFolder);
rawDir = fullfile(expRoot,subFolder);
lfpD = dir(fullfile(rawDir, '*.lf.bin'));
lfpFilename = fullfile(rawDir, lfpD(1).name);

figDir = fullfile(ksDir, 'figs');
if ~exist(figDir); mkdir(figDir); end

%% see if we can get the gain factor
addGainToParamsPy(ksDir, rawDir);

%% load and compute basics
% sp = loadKSdir(fullfile(dataRoot, 'ephys_AM'));

fprintf(1, 'loading spiking data\n'); tic
sp = loadKSdir(ksDir);

[spikeAmps, spikeDepths, templateYpos, tempAmps, tempsUnW, tempDur, tempPeakWF] = ...
    templatePositionsAmplitudes(sp.temps, sp.winv, sp.ycoords, sp.spikeTemplates, sp.tempScalingAmps);

if isfield(sp, 'gain')
    spikeAmps = spikeAmps*sp.gain;
    tempAmps = tempAmps*sp.gain;
else
    sp.gain = 1;
end

sp.spikeAmps = spikeAmps;
sp.spikeDepths = spikeDepths;
sp.templateYpos = templateYpos;
sp.tempAmps = tempAmps;
sp.tempsUnW = tempsUnW;
sp.tempDur = tempDur;
sp.tempPeakWF = tempPeakWF;
toc

%% driftmap

fprintf(1, 'computing driftmap\n'); tic

[~,~, sd] = ksDriftmap(ksDir);
sp.spikeDepths = sd; % more accurate version of depths based on PCs.
sa = sp.spikeAmps;
st = sp.st;

%% plotting driftmap

inclSpikes = find(sa>50);


nUse = min(length(inclSpikes), maxPlotDriftmap); 
rp = randperm(length(inclSpikes));
useSpikes = inclSpikes(rp(1:nUse));    

toc; 
fprintf(1, 'plotting driftmap and saving\n'); tic

fdm = figure;
plotDriftmap(st(useSpikes), sa(useSpikes), sd(useSpikes))
set(fdm, 'Position', [-1896         -49        1271         961]);
if length(inclSpikes)>maxPlotDriftmap
    title(sprintf('subsampled from %d to %d spikes (%.2f%%)', length(inclSpikes), maxPlotDriftmap, maxPlotDriftmap/length(inclSpikes)));
end

%% save the global one, but also zoom in to segments
saveFig(fdm, fullfile(figDir, 'driftmapAll'), 'jpg');
for x = 0:300:3600
    ylim([x x+300]);
    saveFig(fdm, fullfile(figDir, sprintf('driftmap%d_%d', x, x+300)), 'jpg');
end
toc

%% waveform cdfs

fprintf(1, 'waveform amplitude distributions\n'); tic

depthBins = 0:40:3840;
ampBins = 0:30:min(max(spikeAmps),800);
recordingDur = sp.st(end);

[pdfs, cdfs] = computeWFampsOverDepth(spikeAmps, spikeDepths, ampBins, depthBins, recordingDur);
fcdfs = plotWFampCDFs(pdfs, cdfs, ampBins, depthBins);

ch = get(fcdfs, 'Children');
chTypes = get(ch, 'Type');
cbar = ch(strcmp(chTypes, 'colorbar'));
cbar.Label.String = 'firing rate (sp/s)';

saveFig(fcdfs, fullfile(figDir, 'waveformAmplitudes'), 'jpg');
toc
%% another version of waveform amplitudes across depth

fprintf(1, 'waveform amplitude distributions (2) \n'); tic
depthBins = 0:120:3840; % for this one use coarser bins
ampBins = linspace(0,min(max(spikeAmps),800), 12); 
recordingDur = sp.st(end);

[pdfs, cdfs] = computeWFampsOverDepth(spikeAmps, spikeDepths, ampBins, depthBins, recordingDur);

%%
fcdfs2 = figure;
colors = parula(length(ampBins));
for q = 3:length(ampBins)-1
    plot(cdfs(:,q), depthBins(1:end-1), 'Color', colors(q,:)); hold on;
end
xlabel('firing rate at given amplitude (in �V) or above (sp/s)');
ylabel('depth on probe (�m)');
% h = legend(array2stringCell(ampBins(3:end-1)));
h = legend(cellfun(@(x)sprintf('%d', round(ampBins(x))), num2cell(3:length(ampBins)-1), 'uni', false),...
    'Location', 'EastOutside');
% set(gca, 'Color', 'k');
% set(h, 'TextColor', 'w');

makepretty;

saveFig(fcdfs2, fullfile(figDir, 'waveformAmplitudes2'), 'jpg');

toc

%% compute RMS over probe
fprintf(1, 'RMS by channel\n'); tic
gainFactor = sp.gain;
[rmsPerChannelV, madPerChannelV] = computeRawRMS(ksDir, gainFactor, rawDir);

%% plot RMS

xc = sp.xcoords; yc = sp.ycoords;

frms = figure;
plotAsPhase3(rmsPerChannelV, xc, yc);
axis on; box off; set(gca, 'XTick', []);
colormap hot
caxis([7 30]);
h = colorbar;
h.Label.String = 'RMS voltage (�V)';
set(frms, 'Position', [-1896         -24         237         936]);
saveFig(frms, fullfile(figDir, 'rmsVoltage'), 'jpg');

toc
%% compute LFP power
fprintf(1, 'LFP power\n'); tic

fn = getMetaFname(ksDir, rawDir, 'LFP');
meta = readSpikeGLXmeta(fn);

lfpFs = meta.sRateHz; 
nChansInFile = meta.nSavedChans; 

freqBand = [];

[lfpByChannel, allPowerEst, F, allPowerVar] = lfpBandPower(lfpFilename, lfpFs, nChansInFile, freqBand);

chanMap = readNPY(fullfile(ksDir, 'channel_map.npy'));
nC = length(chanMap);

allPowerEst = allPowerEst(:,chanMap+1)'; % now nChans x nFreq



%% plot LFP power
dispRange = [0 100]; % Hz
marginalChans = [10:50:nC];
freqBands = {[1.5 4], [4 10], [10 30], [30 80], [80 200]};


flfp = plotLFPpower(F, allPowerEst, dispRange, marginalChans, freqBands);
set(flfp, 'Position', [-1896         -18        1564         930]);

saveFig(flfp, fullfile(figDir, 'lfpPower'), 'jpg');

toc
