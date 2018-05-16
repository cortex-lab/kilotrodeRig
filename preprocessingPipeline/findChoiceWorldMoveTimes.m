

function [responseMoveInds, earlyMoveInds, allMoveInds] = findChoiceWorldMoveTimes(es)
% All returned entries are indexes into es.wheelDat.moveTimes, .moveAmp, .movePeakVel (etc) 

trialStarts = es.cwEvents.trialStarted;
trialEnds = es.cwEvents.trialEnded;
stimOn = es.cwEvents.stimulusCueStarted;
if isfield(es.cwEvents, 'onsetToneSoundPlayed')
    beepOn = es.cwEvents.onsetToneSoundPlayed;
elseif isfield(es.cwEvents, 'onsetToneSoundPlayed2')
    beepOn = es.cwEvents.onsetToneSoundPlayed2;
else
    disp('could not find beep onset...');
    keyboard;
end

responseMadeLabel = es.cwLabels.responseMade;
responseMadeTimes = es.cwEvents.responseMade;

moveTimes = es.wheelDat.moveTimes;
moveAmps = es.wheelDat.moveAmp;

[responseMoveInds, earlyMoveInds, allMoveInds] = findChoiceWorldMoveTimesDirect(...
    trialStarts, trialEnds, stimOn, beepOn, moveTimes, moveAmps, responseMadeLabel, responseMadeTimes);