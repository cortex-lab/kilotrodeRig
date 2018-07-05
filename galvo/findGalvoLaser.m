

function [galvoPos, laserAmp] = findGalvoLaser(Timeline, block, rig, bBlockToTL)
%function [galvoPos, laserAmp] = findGalvoLaser(Timeline, block, bBlockToTL)
%

% load stuff

mWperV = block.paramsValues(1).mWperV;

s = rig.daqController.SignalGenerators;
n = rig.daqController.ChannelNames;

if ~isempty(s)
    mmPerVx = s(strcmp(n, 'galvoX')).Scale; 
    mmPerVy = s(strcmp(n, 'galvoY')).Scale;
else
    mmPerVx = 1; mmPerVy = 1;
end

tt = Timeline.rawDAQTimestamps; Fs = Timeline.hw.daqSampleRate;
gx = Timeline.rawDAQData(:, strcmp({Timeline.hw.inputs.name}, 'galvoX'));
gy = Timeline.rawDAQData(:, strcmp({Timeline.hw.inputs.name}, 'galvoY'));
las = Timeline.rawDAQData(:, strcmp({Timeline.hw.inputs.name}, 'waveOutput'));

gxMM = gx/mmPerVx;
gyMM = gy/mmPerVy;
lasmW = (las-0.12)*mWperV;


% get trial starts/stops in timeline
cwEvT = basicCWevents(block);
ts = applyCorrection(cwEvT.trialStarts, bBlockToTL);
te = applyCorrection(cwEvT.trialEnds, bBlockToTL);
so = applyCorrection(cwEvT.stimOn, bBlockToTL);

% find values 200ms after stim onset (assuming it is stable there)
gxm = arrayfun(@(x)gxMM(find(tt>x,1)), so+0.2);
gym = arrayfun(@(x)gyMM(find(tt>x,1)), so+0.2);
lasm = arrayfun(@(x)lasmW(find(tt>x,1)), so+0.2);

galvoPos = [gxm gym]; laserAmp = lasm;

return

%% wrapper/test

load(dat.expFilePath(mouseName, thisDate, tlExpNum, 'Timeline', 'master'));

p = dat.paths;
load(dat.expFilePath(mouseName, thisDate, cwExpNum, 'Block', 'master'));
rig = load(fullfile(p.globalConfig, block.rigName, 'hardware.mat'));

root = getRootDir(mouseName, thisDate);
alignDir = fullfile(root, 'alignments');
bBlockToTL= readNPY(fullfile(alignDir, ...
            sprintf('correct_block_%d_to_timeline_%d.npy', cwExpNum, tlExpNum)));

%%
[galvoPos, laserAmp] = findGalvoLaser(Timeline, block, rig, bBlockToTL);
