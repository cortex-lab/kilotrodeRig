

function [cwtP, cweP] = loadPassiveCW(mouseName, thisDate, tlExpNum, passiveExpNum, Timeline)

% rootE = dat.expPath(mouseName, thisDate, 1, 'main', 'master');
% root = fileparts(rootE);
root = getRootDir(mouseName, thisDate);
alignDir = fullfile(root, 'alignments');

[tags, hasEphys] = getEphysTags(mouseName, thisDate);
bTLtoEphys = readNPY(fullfile(alignDir, ...
            sprintf('correct_timeline_%d_to_ephys_%s.npy', tlExpNum, tags{1})));

% swTL = readNPY(fullfile(alignDir, sprintf('block_%d_sw_in_timeline_%d.npy', passiveExpNum, tlExpNum)));
bBlockToTLp = readNPY(fullfile(alignDir, ...
            sprintf('correct_block_%d_to_timeline_%d.npy', passiveExpNum, tlExpNum)));
        
load(dat.expFilePath(mouseName, thisDate, passiveExpNum, 'block', 'master'));

load(dat.expFilePath(mouseName, thisDate, passiveExpNum, 'parameters', 'master'));

%%
[beepsTL, whiteNoiseTL, valveClicksTL] = extractTimelineSignals(Timeline);

beeps = applyCorrection(beepsTL, bTLtoEphys);   
whiteNoise = applyCorrection(whiteNoiseTL, bTLtoEphys);        
valveClicks = applyCorrection(valveClicksTL, bTLtoEphys);

%% extract events
[cwtB, cwe] = basicCWevents(block);

% P here is for Passive
cwtCorr = structfun(@(x)applyCorrection(applyCorrection(x,bBlockToTLp), bTLtoEphys), cwtB, 'uni', false);
cwtP = struct2table(cwtCorr);

cweP = struct2table(cwe);

%%
tr = block.trial; tr = tr(1:block.numCompletedTrials);
cond = [tr.condition];

cweP.condNums = getBlockCondNums(parameters, cond)';

cweP.hasBeep = [cond.interactiveOnsetToneRelAmp]'>0.001;

cweP.hasClick = cweP.feedback==1;

cweP.hasWhiteNoise = cweP.feedback==-1 & [cond.negFeedbackSoundAmp]'>0.001; 

theseBeeps = beeps(beeps>cwtP.trialStarts(1) & beeps<cwtP.trialEnds(end));
theseWhiteNoise = whiteNoise(whiteNoise>cwtP.trialStarts(1) & whiteNoise<cwtP.trialEnds(end));
theseValveClicks = valveClicks(valveClicks>cwtP.trialStarts(1) & valveClicks<cwtP.trialEnds(end));

whos theseBeeps theseWhiteNoise theseValveClicks

%% if those look good (25 each), add them

try
    cwtP.goCue = nan(size(cwtP.goCue));
    cwtP.goCue(cweP.hasBeep) = theseBeeps;
    
    cwtP.responseTime = nan(size(cwtP.responseTime));
    
    if numel(theseWhiteNoise)>sum(cweP.hasWhiteNoise)
        q = WithinRanges(theseWhiteNoise, [cwtP.trialStarts cwtP.trialEnds], [1:size(cwtP,1)]', 'vector');
        theseWhiteNoise = theseWhiteNoise(ismember(q,find(cweP.hasWhiteNoise)));
        q = WithinRanges(theseWhiteNoise, [cwtP.trialStarts cwtP.trialEnds], [1:size(cwtP,1)]', 'vector');
        x = find(diff([0 q])==0); %duplicates
        if ~isempty(x)
            for xx = 1:numel(x); theseWhiteNoise = theseWhiteNoise([1:x(xx)-1 x(xx)+1:end]); end
        end
        whos theseWhiteNoise
    end
    
    cwtP.responseTime(cweP.hasWhiteNoise) = theseWhiteNoise;
    cwtP.responseTime(cweP.hasClick) = theseValveClicks;
catch
    keyboard;
end