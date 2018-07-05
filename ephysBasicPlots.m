

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

function ephysBasicPlots(mouseName, thisDate, tag)

%% 

% clear all; close all;

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

% mouseName = 'SS072'; 
% % thisDate = '2016-12-02';
% % tag = 'V1'; % V1, SC
% thisDate = '2016-12-04';
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
% thisDate = '2017-01-09';
% tag = 'V1'; %V1, M2
% thisDate = '2017-01-10';
% tag = 'AM'; %AM, M2
% thisDate = '2017-01-11';
% tag = 'RSP'; %PM, RSP
% thisDate = '2017-01-12';
% tag = 'S1'; %M1, S1
% thisDate = '2017-01-13';
% tag = 'M1'; %V1, M1

% mouseName = 'Houssay'; 
% thisDate = '2017-01-14';
% tag = [];

% mouseName = 'Gasser'; 
% thisDate = '2017-01-15';
% tag = [];

% mouseName = 'Fleming'; 
% thisDate = '2017-01-15';
% tag = [];

% expPath = dat.expPath(mouseName, thisDate, 1, 'main', 'master');
% expRoot = fileparts(expPath);
expRoot = getRootDir(mouseName, thisDate);

if ~exist('tag') || isempty(tag)
    subFolder = 'ephys';
    tag = [];
else
    subFolder = ['ephys_' tag];
end
    
    
% ksDir = fullfile('\\basket.cortexlab.net\data\nick\', mouseName, thisDate, subFolder);
ksDir = getKSdir(mouseName, thisDate, tag);
rawDir = fullfile(expRoot,subFolder);
lfpD = dir(fullfile(rawDir, '*.lf.bin'));
lfpFilename = fullfile(rawDir, lfpD(1).name);

% figDir = fullfile(ksDir, 'figs');
figDir = getFigDir(mouseName, thisDate, tag);
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

inclSpikes = find(sa>75);


nUse = min(length(inclSpikes), maxPlotDriftmap); 
rp = randperm(length(inclSpikes));
useSpikes = inclSpikes(rp(1:nUse));    

toc; 
fprintf(1, 'plotting driftmap and saving\n'); tic

fdm = figure;
plotDriftmap(st(useSpikes), sa(useSpikes), sd(useSpikes))
p = get(fdm, 'Position'); set(fdm, 'Position', [p(1) p(2)       1271         961]);
if length(inclSpikes)>maxPlotDriftmap
    title(sprintf('subsampled from %d to %d spikes (%.2f%%)', length(inclSpikes), maxPlotDriftmap, maxPlotDriftmap/length(inclSpikes)));
end

%% save the global one, but also zoom in to segments
saveFig(fdm, fullfile(figDir, 'driftmapAll'), 'jpg');
for x = 0:300:3600
    ylim([x x+300]);
    saveFig(fdm, fullfile(figDir, sprintf('driftmap%d_%d', x, x+300)), 'jpg');
end
ylim([0 4000]);
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
xlabel('firing rate at given amplitude (in µV) or above (sp/s)');
ylabel('depth on probe (µm)');
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

frms = figure; p = get(frms,'Position');
plotAsPhase3(rmsPerChannelV, xc, yc);
axis on; box off; set(gca, 'XTick', []);
colormap hot
caxis([7 30]);
h = colorbar;
h.Label.String = 'RMS voltage (µV)';
set(frms, 'Position', [p(1) p(2)         237         936]);
saveFig(frms, fullfile(figDir, 'rmsVoltage'), 'jpg');

toc
%% compute LFP power
fprintf(1, 'LFP power\n'); tic

fn = getMetaFname(ksDir, rawDir, 'LFP');
meta = readSpikeGLXmeta(fn);

lfpFs = meta.sRateHz; 
nChansInFile = meta.nSavedChans; 

[~, allPowerEst, F] = lfpBandPower(lfpFilename, lfpFs, nChansInFile, []);

chanMap = readNPY(fullfile(ksDir, 'channel_map.npy'));
nC = length(chanMap);

allPowerEst = allPowerEst(:,chanMap+1)'; % now nChans x nFreq



%% plot LFP power
dispRange = [0 100]; % Hz
marginalChans = [10:50:nC];
freqBands = {[1.5 4], [4 10], [10 30], [30 80], [80 200]};


flfp = plotLFPpower(F, allPowerEst, dispRange, marginalChans, freqBands);
p = get(flfp, 'Position'); set(flfp, 'Position', [p(1) p(2)       1564         930]);

saveFig(flfp, fullfile(figDir, 'lfpPower'), 'jpg');




%%
toc
return;

%%

clear r;
n = 0; 
n = n+1; r(n).mouseName = 'Cori'; r(n).thisDate = '2016-12-14'; r(n).tlExpNum = 1; r(n).cwExpNum = 2; r(n).passiveExpNum = 4; 
n = n+1; r(n).mouseName = 'Cori'; r(n).thisDate = '2016-12-15'; r(n).tlExpNum = 1; r(n).cwExpNum = 2; r(n).passiveExpNum = 5; 
n = n+1; r(n).mouseName = 'Cori'; r(n).thisDate = '2016-12-16'; r(n).tlExpNum = 1; r(n).cwExpNum = 2; r(n).passiveExpNum = 4; 
n = n+1; r(n).mouseName = 'Cori'; r(n).thisDate = '2016-12-17'; r(n).tlExpNum = 1; r(n).cwExpNum = 2; r(n).passiveExpNum = 4; 
n = n+1; r(n).mouseName = 'Cori'; r(n).thisDate = '2016-12-18'; r(n).tlExpNum = 1; r(n).cwExpNum = 2; r(n).passiveExpNum = 4; 

n = n+1; r(n).mouseName = 'Radnitz'; r(n).thisDate = '2017-01-08'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = 5; 
n = n+1; r(n).mouseName = 'Radnitz'; r(n).thisDate = '2017-01-09'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = 5; 
n = n+1; r(n).mouseName = 'Radnitz'; r(n).thisDate = '2017-01-10'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = 5; 
n = n+1; r(n).mouseName = 'Radnitz'; r(n).thisDate = '2017-01-11'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = 5; 
n = n+1; r(n).mouseName = 'Radnitz'; r(n).thisDate = '2017-01-12'; r(n).tlExpNum = 1; r(n).cwExpNum = 2; r(n).passiveExpNum = 4; 
n = n+1; r(n).mouseName = 'Radnitz'; r(n).thisDate = '2017-01-13'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = []; 

n = n+1; r(n).mouseName = 'Muller'; r(n).thisDate = '2017-01-07'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = 5; 
n = n+1; r(n).mouseName = 'Muller'; r(n).thisDate = '2017-01-08'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = 5; 
n = n+1; r(n).mouseName = 'Muller'; r(n).thisDate = '2017-01-09'; r(n).tlExpNum = 3; r(n).cwExpNum = 4; r(n).passiveExpNum = 6; 
n = n+1; r(n).mouseName = 'Muller'; r(n).thisDate = '2017-01-10'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = 5; 
n = n+1; r(n).mouseName = 'Muller'; r(n).thisDate = '2017-01-11'; r(n).tlExpNum = 1; r(n).cwExpNum = 2; r(n).passiveExpNum = 4; 
n = n+1; r(n).mouseName = 'Muller'; r(n).thisDate = '2017-01-12'; r(n).tlExpNum = 3; r(n).cwExpNum = 4; r(n).passiveExpNum = 6; 

%%
clear r
r.mouseName = 'Hess'; r.thisDate = '2017-04-03';

%%
clear r; 
r.mouseName = 'Krebs'; r.thisDate = '2017-06-05';

%%
clear r; 
r.mouseName = 'Waksman'; r.thisDate = '2017-06-10';
%%
clear r; 
r.mouseName = 'Robbins'; r.thisDate = '2017-06-13';

%%
clear r; n= 0;
n = n+1; r(n).mouseName = 'Hench'; r(n).thisDate = '2017-06-14';
n = n+1; r(n).mouseName = 'Hench'; r(n).thisDate = '2017-06-15';
n = n+1; r(n).mouseName = 'Hench'; r(n).thisDate = '2017-06-16';
n = n+1; r(n).mouseName = 'Hench'; r(n).thisDate = '2017-06-17';
n = n+1; r(n).mouseName = 'Hench'; r(n).thisDate = '2017-06-18';

%%
clear r; n= 0;
% n = n+1; r(n).mouseName = 'Moniz'; r(n).thisDate = '2017-05-13';
% n = n+1; r(n).mouseName = 'Moniz'; r(n).thisDate = '2017-05-14';
% n = n+1; r(n).mouseName = 'Moniz'; r(n).thisDate = '2017-05-15';
% n = n+1; r(n).mouseName = 'Moniz'; r(n).thisDate = '2017-05-16';
n = n+1; r(n).mouseName = 'Moniz'; r(n).thisDate = '2017-05-17';
n = n+1; r(n).mouseName = 'Moniz'; r(n).thisDate = '2017-05-18';
% n = n+1; r(n).mouseName = 'Moniz'; r(n).thisDate = '2017-05-19';



%%
for n = 1:length(r)
    fn = fieldnames(r); for f = 1:length(fn); eval([fn{f} ' = r(n).(fn{f});']); end;
    try
        fprintf(1, '%s - %s\n', mouseName, thisDate);
          
        ksRoot = fullfile('\\basket.cortexlab.net\data\nick', mouseName, thisDate);
        rootFigDir = fullfile(ksRoot, 'figs'); mkdir(rootFigDir);
        
        rootE = dat.expPath(mouseName, thisDate, 1, 'main', 'master');
        root = fileparts(rootE);
        
        [tags, hasEphys] = getEphysTags(mouseName, thisDate);
        for t = 1:length(tags)
            fprintf(1, '  %s\n', tags{t});
        
            ephysBasicPlots(mouseName, thisDate, tags{t});
        end

        close all;
        
    catch me
        disp(me)
    end
end
