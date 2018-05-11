

function [cwtA, cweA] = loadActiveCW(mouseName, thisDate, tlExpNum, cwExpNum, Timeline)

% rootE = dat.expPath(mouseName, thisDate, 1, 'main', 'master');
% root = fileparts(rootE);
root = getRootDir(mouseName, thisDate);

alignDir = fullfile(root, 'alignments');

[tags, hasEphys] = getEphysTags(mouseName, thisDate);
if hasEphys
    bTLtoEphys = readNPY(fullfile(alignDir, ...
                sprintf('correct_timeline_%d_to_ephys_%s.npy', tlExpNum, tags{1})));
else
    bTLtoEphys = [1 0];
end
%% all of the timeline-detectable events
% load(dat.expFilePath(mouseName, thisDate, tlExpNum, 'Timeline', 'master'));
% Timeline = tl{tlExpNum};
[beepsTL, whiteNoiseTL, valveClicksTL] = extractTimelineSignals(Timeline);

beeps = applyCorrection(beepsTL, bTLtoEphys);        
whiteNoise = applyCorrection(whiteNoiseTL, bTLtoEphys);        
valveClicks = applyCorrection(valveClicksTL, bTLtoEphys);        
        
%% first block, choiceworld

swTL = readNPY(fullfile(alignDir, sprintf('block_%d_sw_in_timeline_%d.npy', cwExpNum, tlExpNum)));
bBlockToTL= readNPY(fullfile(alignDir, ...
            sprintf('correct_block_%d_to_timeline_%d.npy', cwExpNum, tlExpNum)));
        
load(dat.expFilePath(mouseName, thisDate, cwExpNum, 'block', 'master'));
% block = blocks{cwExpNum};

%% extract events
[cwtB, cwe] = basicCWevents(block);

% A here is for Active
cwtCorr = structfun(@(x)applyCorrection(applyCorrection(x,bBlockToTL), bTLtoEphys), cwtB, 'uni', false);
cwtA = struct2table(cwtCorr);

cweA = struct2table(cwe);

cweA.inclTrials = true(size(cweA.choice));

warning('OUGHT TO USE PHOTODIODE TO GET STIM ONSET TIMES HERE: loadActiveCW\n');

%% check that timeline-measured stuff matches

allRewards = applyCorrection(applyCorrection(block.rewardDeliveryTimes, bBlockToTL), bTLtoEphys);
trialRewards = cwtA.responseTime(cweA.feedback==1);
trialNegFeedback = cwtA.responseTime(cweA.feedback==-1);
theseBeeps = beeps(beeps>cwtA.trialStarts(1) & beeps<cwtA.trialEnds(end));
theseWhiteNoise = whiteNoise(whiteNoise>cwtA.trialStarts(1) & whiteNoise<cwtA.trialEnds(end));
theseValveClicks = valveClicks(valveClicks>cwtA.trialStarts(1) & valveClicks<cwtA.trialEnds(end));
theseRewards = theseValveClicks(abs(findMinDiffs(theseValveClicks, cwtA.responseTime(cweA.feedback==1)))<0.05);
goCue = cwtA.goCue;

whos theseValveClicks allRewards
whos theseRewards trialRewards 
whos theseBeeps goCue
whos theseWhiteNoise trialNegFeedback
 
%% if those matched, we can put these more-accurate times in
cwtA.beeps = theseBeeps;

if length(theseWhiteNoise)~=length(trialNegFeedback)
    theseWhiteNoise=trialNegFeedback; % didn't detect all the white noises correctly, just use the block times.
end
cwtA.feedbackTime = sort([theseWhiteNoise; theseRewards]);
