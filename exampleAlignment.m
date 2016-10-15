

% Example alignment script for Kilotrode rig
% set mouseName, thisDate, and expNum first
%
% - Extracts times of rewards, beeps, wheel turns, licks
% - Loads timestamps of frames of eye and face movies
% - Loads timestamps of widefield if present
% - Computes example alignment with ephys
%
% For choiceworld:
% - Computes alignment between block and TL to get stimulus onset times
%
% For mpep:
% - Computes stimulus onset times and IDs
%
%

%% load timeline 

load(dat.expFilePath(mouseName, thisDate, expNum, 'Timeline', 'master'));
tt = Timeline.rawDAQTimestamps;

%% Reward times: compute directly from timeline

rew = Timeline.rawDAQData(:, strcmp({Timeline.hw.inputs.name}, 'rewardEcho'));

[~, rewardOnsets] = schmittTimes(tt,rew, [2 3]);

%% sounds played: compute directly from timeline

aud = Timeline.rawDAQData(:, strcmp({Timeline.hw.inputs.name}, 'audioMonitor'));

aud = conv(aud.^2, gausswin(100), 'same'); % smooth

[~, soundOnsets] = schmittTimes(tt,aud, [0.02 0.03]); 

% may have to choose this threshold by inspection:
% figure; plot(tt, aud);

%% laser times: compute directly from timeline

las = Timeline.rawDAQData(:, strcmp({Timeline.hw.inputs.name}, 'waveOutput'));

[~, laserOnsets] = schmittTimes(tt,aud, [0.2 0.3]); 

% may have to choose this threshold by inspection, depending on your settings:
% figure; plot(tt, las);

% if using sine wave and only want the first, e.g., then:
laserOnsets = laserOnsets(diff([0;laserOnsets])>0.1); % choose events that don't have another event within preceding 100ms


%% eye and face videos (this may take some time, like five or ten minutes, to run)

alignVideo(mouseName, thisDate, expNum, 'eye');

tsPath = dat.expFilePath(mouseName, thisDate, expNum, 'eyetracking', 'master');
tsPath = fullfile(fileparts(tsPath), 'eye_timeStamps.mat');
load(tsPath);
eyeT = tVid;

alignVideo(mouseName, thisDate, expNum, 'face');

tsPath = dat.expFilePath(mouseName, thisDate, expNum, 'eyetracking', 'master');
tsPath = fullfile(fileparts(tsPath), 'face_timeStamps.mat');
load(tsPath);
faceT = tVid;


%%
load(dat.expFilePath(mouseName, thisDate, expNum, 'block', 'master'));

%% Some things from the block

tr = block.trial; tr = tr(1:block.numCompletedTrials);
cond = [tr.condition];
stimOn = [tr.stimulusCueStartedTime];
vcc = [cond.visCueContrast];
contrastLeft = vcc(1,:);
contrastRight = vcc(2,:);
choice = [tr.responseMadeID];
goCue = [tr.interactiveStartedTime];
responseTime = [tr.responseMadeTime];
reactionTime = [tr.responseMadeTime]-goCue;
feedback = [tr.feedbackType];
repNum = [cond.repeatNum];
trialStarts = [tr.trialStartedTime];
trialEnds = [tr.trialEndedTime];

[contrastCondDefs, ia, contrastCondsRaw] = unique(vcc', 'rows');

sw = block.stimWindowUpdateTimes;

%% get alignment between block and timeline

pd = Timeline.rawDAQData(:,strcmp({Timeline.hw.inputs.name}, 'photoDiode'));
pdFlips = schmittTimes(tt,pd, [3 5]);

figure; 
plot(sw, ones(size(sw)), '.');
hold on; 
plot(pdFlips, ones(size(pdFlips))+1, '.');
ylim([-3 6])

blockToTL = makeCorrection(pdFlips(2:end-1), sw, true);