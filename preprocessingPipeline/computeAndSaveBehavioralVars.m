
function computeAndSaveBehavioralVars(mouseName, thisDate, cwExpNum, tlExpNum)


% mouseName = 'Cori';
% thisDate = '2016-12-18';
% tlExpNum = 1;
% cwExpNum = 2;
fprintf(1, 'loading Timeline\n');
load(dat.expFilePath(mouseName, thisDate, tlExpNum, 'Timeline', 'master'));
fprintf(1, 'loading active\n');
[cwtA, cweA] = loadActiveCW(mouseName, thisDate, tlExpNum, cwExpNum, Timeline);
% activeData.cwt = cwtA; activeData.cwe = cweA;

% rootE = dat.expPath(mouseName, thisDate, 1, 'main', 'master');
% root = fileparts(rootE);
root = getRootDir(mouseName, thisDate);

alignDir = fullfile(root, 'alignments');

[tags, hasEphys] = getEphysTags(mouseName, thisDate);
bTLtoEphys = readNPY(fullfile(alignDir, ...
            sprintf('correct_timeline_%d_to_ephys_%s.npy', tlExpNum, tags{1})));


%% variables to analyze: lick detector
tt = applyCorrection(Timeline.rawDAQTimestamps, bTLtoEphys);
Fs = Timeline.hw.daqSampleRate;

lickSig = Timeline.rawDAQData(:,strcmp({Timeline.hw.inputs.name}, 'piezoLickDetector'));
% lickSigC = conv(abs(lickSig), myGaussWin(0.01, Fs), 'same');
% lickSigCdownsamp = lickSigC(1:5:end); ttdown = tt(1:5:end); % just for speed, there's no reason not to
% [pks,lickTimes] = findpeaks(lickSigCdownsamp, ttdown, 'MinPeakDistance', 0.05, 'MinPeakProminence', 0.03);
[lickTimes, lickSigC, pks] = piezoLickDetector(tt, lickSig, Fs, 0.03);

figure; 
hold on; plot(tt, lickSig)
hold on; plot(tt, lickSigC, 'LineWidth', 2.0)
hold on; plot(lickTimes, pks, 'ko')

tLick = tt;
tLick = tLick(1:5:end); lickSigC = lickSigC(1:5:end);
save(fullfile(root, 'lickData'), 'tLick', 'lickSigC', 'lickTimes');

%% wheel

rotEnc = double(Timeline.rawDAQData(:,strcmp({Timeline.hw.inputs.name}, 'rotaryEncoder')));
rotEnc(rotEnc>2^31) = rotEnc(rotEnc>2^31)-2^32;
rotEncD = diff([0; rotEnc]);
wheelVel = conv(rotEncD, myGaussWin(0.03, Fs), 'same');

% -- new code
Fs = 1000;
tWheel = tt(1:5:end); 
wheelVel = wheelVel(1:5:end);
wheelRaw = rotEnc;
[moveOnsets, moveOffsets, moveAmp, peakVelTimes] = wheel.findWheelMoves3(wheelRaw, tt, Fs, []);

resp = cweA.choice; hasTurn = resp==1|resp==2; resp = resp(hasTurn);
intStartTime = cwtA.goCue(hasTurn); respTime = cwtA.responseTime(hasTurn);
moveType = wheel.classifyWheelMoves(tt, wheelRaw, moveOnsets, moveOffsets, intStartTime, respTime, resp);
clear dm; dm.moveOnsets = moveOnsets; dm.moveOffsets = moveOffsets; dm.moveType = moveType;
plotWheel(tt, wheelRaw, dm);
moveTimes = [moveOnsets moveOffsets]';
movePeakVel = interp1(tWheel, wheelVel, peakVelTimes);

% -- end new code

% -- old code
% thresh = 0.05;
% minBetweenMoves = 0.2;
% [moveTimes, moveAmp, movePeakVel] = findWheelMoves2(tt, wheelVel, rotEnc, thresh, minBetweenMoves);

% tWheel = tt(1:5:end); 
% wheelVel = wheelVel(1:5:end);

% save(fullfile(root, 'wheelData'), 'tWheel', 'wheelVel', 'moveTimes', 'moveAmp', 'movePeakVel');
% -- end old code? 


save(fullfile(root, 'wheelData'), 'tWheel', 'wheelVel', 'moveTimes', 'moveAmp', 'movePeakVel');

%%
% figure; plot(tWheel, abs(wheelVel));
% hold on; plot(moveTimes, abs(movePeakVel), 'ro')
% 
% figure; hist(movePeakVel, 100)
% looks like there are two distinct peaks, one for moves with peak vel >0.3
% or 0.4, and another for moves with very small peak vel. The former
% probably represent all the "intentional" moves, in the task sense

%% 
[responseMoveInds, earlyMoveInds, allMoveInds] = findChoiceWorldMoveTimesDirect(...
    cwtA.trialStarts, cwtA.trialEnds, cwtA.stimOn, cwtA.beeps, moveTimes, moveAmp, ...
    cweA.choice, cwtA.responseTime);

moveStart = NaN(size(cwtA,1),1);
moveStart(responseMoveInds>0) = moveTimes(1,responseMoveInds(responseMoveInds>0));
moveEnd = NaN(size(cwtA,1),1);
moveEnd(responseMoveInds>0) = moveTimes(2,responseMoveInds(responseMoveInds>0));
cwtA.moveStart = moveStart;
cwtA.moveEnd = moveEnd;

earlyMove = NaN(size(cwtA,1),1);
earlyMove(~isnan(earlyMoveInds)) = moveTimes(1,earlyMoveInds(~isnan(earlyMoveInds)));
cwtA.earlyMove = earlyMove;

%%
% set inclTrials first
cweA.inclTrials = true(size(cwtA.stimOn));
lastCorrect = find(cweA.feedback==1, 1, 'last')
cweA.inclTrials(lastCorrect+1:end) = false;
repeatedNogos = find(cweA.repNum>2&cweA.choice==3&(cweA.contrastLeft>0|cweA.contrastRight>0))
cweA.inclTrials(repeatedNogos) = false;
fprintf(1, 'num included trials = %d\n', sum(cweA.inclTrials));

%%
save(fullfile(root, 'activeData'), 'cwtA', 'cweA');


return;


%%
clear all;
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
clear all;
n = 0;

n = n+1; r(n).mouseName = 'Hench'; r(n).thisDate = '2017-06-14'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = 6; 
n = n+1; r(n).mouseName = 'Hench'; r(n).thisDate = '2017-06-15'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = 5; 
n = n+1; r(n).mouseName = 'Hench'; r(n).thisDate = '2017-06-16'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = 5; 
n = n+1; r(n).mouseName = 'Hench'; r(n).thisDate = '2017-06-17'; r(n).tlExpNum = 2; r(n).cwExpNum = 4; r(n).passiveExpNum = 6; 
n = n+1; r(n).mouseName = 'Hench'; r(n).thisDate = '2017-06-18'; r(n).tlExpNum = 1; r(n).cwExpNum = 2; r(n).passiveExpNum = 4; 


%%
% n = 17;

for n = 1:length(r)
fn = fieldnames(r); for f = 1:length(fn); eval([fn{f} ' = r(n).(fn{f});']); end;

computeAndSaveBehavioralVars(mouseName, thisDate, cwExpNum, tlExpNum)
end

%% report on num trials
for n = 1:length(r)
    fn = fieldnames(r); for f = 1:length(fn); eval([fn{f} ' = r(n).(fn{f});']); end;

    rootE = dat.expPath(mouseName, thisDate, 1, 'main', 'master');
    root = fileparts(rootE);
    load(fullfile(root, 'activeData'));
    fprintf(1, '%s - %s: %d\n', mouseName, thisDate, sum(cweA.inclTrials));
end